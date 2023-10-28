import { UserProfileRepository } from "../domain/repository/userProfileRepository";

export const getProfileSearchUserIdUsecase = async (
  r: UserProfileRepository,
  userID: string
) => {
  return await r.FindByUserID(userID);
};
