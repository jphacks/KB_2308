import { UserLocation } from "../domain/model/userLocation";
import { UserLocationRepository } from "../domain/repository/userLocationRepository";

export const putLocationUsecase = async (
  r: UserLocationRepository,
  userId: string,
  locationName: string,
  isCustom: boolean
) => {
  const user = await r.FindByUserID(userId);
  if (!user) {
    throw new Error("user not found");
  }

  user.locationName = locationName;
  user.isCustom = isCustom;

  return await r.Store(user);
};
