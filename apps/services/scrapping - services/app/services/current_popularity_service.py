# services/current_popularity_service.py
from services.cookie_service import get_current_popularity_via_browser

class CurrentPopularityService:

    def get_current_popularity(self, place_name, city="Maringá"):
        return get_current_popularity_via_browser(place_name, city)