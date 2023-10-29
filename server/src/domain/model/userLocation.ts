type TUserLocation = {
  id: string;
  locationName: string;
  isCustom: boolean;
  createdAt: Date;
  updatedAt: Date;
};

interface IUserLocation {}

export class UserLocation implements TUserLocation, IUserLocation {
  id: string;
  locationName: string;
  isCustom: boolean;
  createdAt: Date;
  updatedAt: Date;

  constructor(
    id: string = "",
    locationName: string = "",
    isCustom: boolean = false,
    createdAt: Date = new Date(),
    updatedAt: Date = new Date()
  ) {
    this.id = id;
    this.locationName = locationName;
    this.isCustom = isCustom;
    this.createdAt = createdAt;
    this.updatedAt = updatedAt;
  }
}
