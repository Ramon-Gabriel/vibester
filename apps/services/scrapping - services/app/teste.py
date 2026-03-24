from database.connection import Database
from repositories.place_repository import PlaceRepository
from repositories.popular_times_repository import PopularTimesRepository
from repositories.current_popularity_repository import CurrentPopularityRepository
from services.places_service import PlacesService
from services.current_popularity_service import CurrentPopularityService
from models.place import Place

API_KEY = "AIzaSyAgcC89r1Wq9GUhJbJWeXT6wIYohM8nsNc"

db = Database()
place_repo = PlaceRepository(db)
popular_repo = PopularTimesRepository(db)
current_repo = CurrentPopularityRepository(db)

places_service = PlacesService(API_KEY)
current_service = CurrentPopularityService()

LAT_MIN, LAT_MAX = -23.4400, -23.3900
LNG_MIN, LNG_MAX = -52.0000, -51.8900

print("=" * 50)
print("TESTE - Buscando lugares no bairro...")
print("=" * 50)

import populartimes
resultados = populartimes.get(
    API_KEY,
    ["Bar"],
    (LAT_MIN, LNG_MIN),
    (LAT_MAX, LNG_MAX),
    n_threads=5,
    radius=300
)

print(f"Total encontrado: {len(resultados)}\n")

visited = set()
lugares_salvos = []

for item in resultados:
    place_id = item.get("place_id")
    name = item.get("name")

    if not place_id or place_id in visited:
        continue
    visited.add(place_id)

    place = Place(
        name=name,
        place_id=place_id,
        lat=item.get("coordinates", {}).get("lat"),
        lng=item.get("coordinates", {}).get("lng"),
        rating=item.get("rating")
    )

    try:
        place_repo.save(place)
        lugares_salvos.append((place_id, name))
        print(f"  [SALVO] {name} (rating: {item.get('rating')})")
    except Exception as e:
        print(f"  [ERRO] {name}: {e}")

    popular = item.get("populartimes", [])
    if popular:
        try:
            popular_repo.save(place_id, popular)
            print(f"  [POPULAR TIMES OK] {name}")
        except Exception as e:
            print(f"  [ERRO POPULAR] {e}")

print("\n" + "=" * 50)
print("MOVIMENTO AO VIVO AGORA:")
print("=" * 50)

for place_id, name in lugares_salvos:
    popularity = current_service.get_current_popularity(place_id)
    
    if popularity is not None:
        if popularity >= 70:
            status = "LOTADO"
        elif popularity >= 40:
            status = "MODERADO"
        else:
            status = "VAZIO"
        
        current_repo.save(place_id, popularity)
        print(f"  {status} {name}: {popularity}%")
    else:
        print(f" {name}: sem dado ao vivo")

print("\nTeste finalizado!")