import { FollowRepository } from "../domain/repository/followRepository";

export const getFollowRequestMe = async (r: FollowRepository, myId: string) => {
  return await r.FindFollowsByUserAndStatus(myId, "pending");
};
