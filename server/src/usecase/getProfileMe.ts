import { UserProfileRepository } from "../domain/repository/userProfileRepository";

export const getProfileMeUsecase = async (
  r: UserProfileRepository,
  userId: string
) => {
  return await r.FindByID(userId);
};
