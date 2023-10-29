import { UserProfile } from "../domain/model/userProfile";
import { UserProfileRepository } from "../domain/repository/userProfileRepository";

export const postProfileUsecase = async (
  r: UserProfileRepository,
  userID?: string,
  name?: string,
  imageUrl?: string
) => {
  return await r.Store(new UserProfile(userID, name, imageUrl));
};
