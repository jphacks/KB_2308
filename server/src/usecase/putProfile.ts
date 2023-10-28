import { UserProfile } from "../domain/model/userProfile";
import { UserProfileRepository } from "../domain/repository/userProfileRepository";

export const putProfileUsecase = async (
  r: UserProfileRepository,
  userId: string,
  newName: string,
  newUserID: string,
  newImageUrl: string
) => {
  const user = await r.FindByUserID(userId);
  if (!user) {
    throw new Error("user not found");
  }

  user.name = newName;
  user.userID = newUserID;
  user.imageUrl = newImageUrl;

  return await r.Store(user);
};
