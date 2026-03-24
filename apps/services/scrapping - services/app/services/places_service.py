import populartimes
from models.place import Place

class PlacesService:
    def __init__(self, api_key):
        self.api_key = api_key

    def search_bars(self, lat_min, lat_max, lng_min, lng_max, radius=500):
        try:
            data = populartimes.get(
                self.api_key,
                ["bar", "restaurant", "night_club"],
                (lat_min, lng_min),
                (lat_max, lng_max),
                n_threads=5,
                radius=radius
            )
            return data
        except Exception as e:
            print(f"  ERRO: {e}")
            return []