import { FollowRepository } from "../domain/repository/followRepository";

export const getFollowMeUsercase = async (
  r: FollowRepository,
  myId: string
) => {
  return await r.FindFollowsByUserAndStatus(myId, "friend");
};
