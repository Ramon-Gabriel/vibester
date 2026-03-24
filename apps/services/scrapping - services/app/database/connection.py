import pyodbc

class Database:
    def __init__(self, server='localhost', database='automacaodb'):
        self.conn = pyodbc.connect(
            f'DRIVER={{ODBC Driver 17 for SQL Server}};'
            f'SERVER={server};DATABASE={database};Trusted_Connection=yes;'
        )
        self.cursor = self.conn.cursor()
        self.create_tables()

    def create_tables(self):
        self.cursor.execute("""
        IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='current_popularity' AND xtype='U')
        CREATE TABLE current_popularity (
            id INT IDENTITY(1,1) PRIMARY KEY,
            place_id NVARCHAR(255),
            popularity INT,
            captured_at DATETIME DEFAULT GETDATE(),
            FOREIGN KEY (place_id) REFERENCES places(place_id)
        )
        """)

        self.cursor.execute("""
        IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='current_popularity' AND xtype='U')
        CREATE TABLE current_popularity (
            id INT IDENTITY(1,1) PRIMARY KEY,
            place_id NVARCHAR(255),
            popularity INT,
            captured_at DATETIME DEFAULT GETDATE(),
            FOREIGN KEY (place_id) REFERENCES places(place_id)
        )
        """)

        self.conn.commit()