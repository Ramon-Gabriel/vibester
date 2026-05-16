export interface EstablishmentInterface {
  id: string;
  name: string;
  photoUrl: string;
  bannerUrl: string;
  category: string;
  priceIndicator: string;
  averageRating: number;
  latitude: number;
  longitude: number;
  distanceTo?: number; // Optional locally calculated distance field
}

export interface ListEstablishmentsQuerystring {
  latitude?: number;
  longitude?: number;
}
