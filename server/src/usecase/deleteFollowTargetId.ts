import { FollowRepository } from "../domain/repository/followRepository";

export const deleteFollowTargetIdUsecase = async (
  r: FollowRepository,
  userId: string,
  targetId: string
) => {
  const follow1 = await r.FindFollowByUserIdAndTargetId(userId, targetId);
  const follow2 = await r.FindFollowByUserIdAndTargetId(targetId, userId);
  if (!follow1) {
    throw new Error("not followed");
  }
  if (!follow2) {
    throw new Error("not followed");
  }

  await r.Delete(follow1);
  await r.Delete(follow2);
};
