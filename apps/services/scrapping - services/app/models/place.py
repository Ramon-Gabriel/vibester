class Place:
    def __init__(self, name, place_id, lat, lng, rating=None):
        self.name = name
        self.place_id = place_id
        self.lat = lat
        self.lng = lng
        self.rating = rating