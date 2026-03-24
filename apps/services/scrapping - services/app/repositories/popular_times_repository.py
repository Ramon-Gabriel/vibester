class PopularTimesRepository:
    def __init__(self, db):
        self.db = db

    def save(self, place_id, data):
        for day_data in data:
            day = day_data["name"]
            hours = day_data["data"]

            for hour, level in enumerate(hours):
                self.db.cursor.execute("""
                    INSERT INTO popular_times (place_id, day, hour, level)
                    VALUES (?, ?, ?, ?)
                """, (place_id, day, hour, level))

        self.db.conn.commit()