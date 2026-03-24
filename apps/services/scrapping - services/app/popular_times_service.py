from populartimes import get_id

class PopularTimesService:
    def __init__(self, api_key):
        self.api_key = api_key

    def get_data(self, place_id):
        try:
            data = get_id(self.api_key, place_id)
            return data.get("populartimes", [])
        except:
            return []