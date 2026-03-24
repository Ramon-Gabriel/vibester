class PlaceRepository:
    def __init__(self, db):
        self.db = db

    def save(self, place):
        query = """
        IF NOT EXISTS (SELECT 1 FROM places WHERE place_id = ?)
        INSERT INTO places (name, place_id, lat, lng, rating)
        VALUES (?, ?, ?, ?, ?)
        """
        self.db.cursor.execute(query, (
            place.place_id,
            place.name,
            place.place_id,
            place.lat,
            place.lng,
            place.rating
        ))
        self.db.conn.commit()