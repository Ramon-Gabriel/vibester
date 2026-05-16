import prismaClient from "../prisma/index";
import { EstablishmentInterface } from "../types/establishment.types";

// Haversine formula to calculate the distance between two points on the Earth
export function calculateDistance(lat1: number, lon1: number, lat2: number, lon2: number): number {
  const R = 6371; // Radius of the earth in km
  const dLat = deg2rad(lat2 - lat1);
  const dLon = deg2rad(lon2 - lon1);
  
  const a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
            Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) *
            Math.sin(dLon / 2) * Math.sin(dLon / 2);
            
  const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
  const distance = R * c; // Distance in km
  return distance;
}

function deg2rad(deg: number): number {
  return deg * (Math.PI / 180);
}

export class EstablishmentService {
  /**
   * List all establishments
   * Optionally adds a `distanceTo` property to each if lat/lon are provided.
   */
  static async listEstablishments(userLat?: number, userLon?: number) {
    const establishments = await prismaClient.establishment.findMany();

    if (userLat !== undefined && userLon !== undefined) {
      // Map standard objects to include the distance
      const withDistance = establishments.map(est => {
        const distance = calculateDistance(userLat, userLon, est.latitude, est.longitude);
        return {
          ...est,
          distanceTo: distance
        };
      });

      // Sort by proximity
      withDistance.sort((a, b) => a.distanceTo - b.distanceTo);
      return withDistance;
    }

    return establishments;
  }

  /**
   * Update the rating of an establishment.
   * Note: In a real app, you would likely average this with existing ratings.
   * This implementation just updates the given establishment's averageRating.
   */
  static async updateRating(id: string, newRating: number) {
    return await prismaClient.establishment.update({
      where: { id },
      data: {
        averageRating: newRating
      }
    });
  }
}
