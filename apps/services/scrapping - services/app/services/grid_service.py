class GridService:
    def generate_points(self, center_lat, center_lng, step=0.02, size=3):
        points = []

        for i in range(-size, size):
            for j in range(-size, size):
                lat = center_lat + (i * step)
                lng = center_lng + (j * step)
                points.append((lat, lng))

        return points