from database.connection import Database
from repositories.place_repository import PlaceRepository
from repositories.popular_times_repository import PopularTimesRepository
from repositories.current_popularity_repository import CurrentPopularityRepository
from services.places_service import PlacesService
from services.current_popularity_service import CurrentPopularityService
import schedule
import time
import populartimes

API_KEY = "AIzaSyAgcC89r1Wq9GUhJbJWeXT6wIYohM8nsNc"

db = Database()
place_repo = PlaceRepository(db)
popular_repo = PopularTimesRepository(db)
current_repo = CurrentPopularityRepository(db)

current_service = CurrentPopularityService()

def job_semanal():
    print("[SEMANAL] Atualizando lugares e popular times...")

    resultados = populartimes.get(
        API_KEY,
        ["pub"],
        (-23.4805, -51.9933),
        (-23.3805, -51.8933),
        n_threads=5,
        radius=500
    )

    print(f"Total encontrado: {len(resultados)}")

    visited = set()

    for item in resultados:
        place_id = item.get("place_id")
        name = item.get("name")

        if not place_id or place_id in visited:
            continue

        visited.add(place_id)

        from models.place import Place
        place = Place(
            name=name,
            place_id=place_id,
            lat=item.get("coordinates", {}).get("lat"),
            lng=item.get("coordinates", {}).get("lng"),
            rating=item.get("rating")
        )

        try:
            place_repo.save(place)
            print(f"  [SALVO] {name}")
        except Exception as e:
            print(f"  [ERRO place] {name}: {e}")

        popular = item.get("populartimes", [])
        if popular:
            try:
                popular_repo.save(place_id, popular)
                print(f"  [POPULAR TIMES] {name}")
            except Exception as e:
                print(f"  [ERRO popular] {name}: {e}")

    print("[SEMANAL] Concluido.")

def job_horario():
    print("[HORARIO] Capturando movimento atual...")

    db.cursor.execute("SELECT place_id, name FROM places")
    lugares = db.cursor.fetchall()

    if not lugares:
        print("  Nenhum lugar no banco. Rode o job semanal primeiro.")
        return

    for place_id, name in lugares:
        popularity = current_service.get_current_popularity(name)

        if popularity is not None:
            if popularity >= 70:
                status = "LOTADO"
            elif popularity >= 40:
                status = "MODERADO"
            else:
                status = "TRANQUILO"

            try:
                current_repo.save(place_id, popularity)
                print(f"  [{status}] {name}: {popularity}%")
            except Exception as e:
                print(f"  [ERRO save] {name}: {e}")
        else:
            print(f"  [SEM DADO] {name}")

    print("[HORARIO] Concluido.")

schedule.every().monday.at("03:00").do(job_semanal)
schedule.every().hour.do(job_horario)

job_semanal()
job_horario()

print("\nAgendador rodando...")
while True:
    schedule.run_pending()
    time.sleep(60)