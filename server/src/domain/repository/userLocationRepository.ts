import { UserLocation } from "../model/userLocation";

export interface UserLocationRepository {
  Store(model: UserLocation): Promise<UserLocation>;
  FindByUserID(userID: string): Promise<UserLocation | undefined>;
}
