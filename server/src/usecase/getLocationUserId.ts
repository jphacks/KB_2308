import { UserLocationRepository } from "../domain/repository/userLocationRepository";

export const getLocationUserIdUsecase = async (
  r: UserLocationRepository,
  userId: string
) => {
  return await r.FindByUserID(userId);
};
