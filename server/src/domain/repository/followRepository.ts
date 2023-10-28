import { Follow, FollowStatus } from "../model/follow";
import { UserProfile } from "../model/userProfile";

export interface FollowRepository {
  FindFollowByUserIdAndTargetId(
    userId: string,
    targetId: string
  ): Promise<Follow | undefined>;
  FindFollowsByUserAndStatus(
    userId: string,
    status: FollowStatus
  ): Promise<UserProfile[]>;
  Store(follow: Follow): Promise<Follow>;
  Delete(follow: Follow): Promise<void>;
}
