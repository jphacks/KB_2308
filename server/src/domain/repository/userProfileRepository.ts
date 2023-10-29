import { UserProfile } from "../model/userProfile";

export interface UserProfileRepository {
  FindByID(id: string): Promise<UserProfile | undefined>;
  FindByUserID(userID: string): Promise<UserProfile | undefined>;
  Store(model: UserProfile): Promise<UserProfile>;
}
