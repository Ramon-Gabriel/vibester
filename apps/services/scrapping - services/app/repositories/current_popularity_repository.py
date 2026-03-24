class CurrentPopularityRepository:
    def __init__(self, db):
        self.db = db

    def save(self, place_id, popularity):
        self.db.cursor.execute("""
            INSERT INTO current_popularity (place_id, popularity)
            VALUES (?, ?)
        """, (place_id, popularity))
        self.db.conn.commit()

    def get_latest(self, place_id):
        self.db.cursor.execute("""
            SELECT TOP 1 popularity, captured_at
            FROM current_popularity
            WHERE place_id = ?
            ORDER BY captured_at DESC
        """, (place_id,))
        return self.db.cursor.fetchone()