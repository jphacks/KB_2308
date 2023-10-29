import { FollowRepository } from "../domain/repository/followRepository";
import { UserProfileRepository } from "../domain/repository/userProfileRepository";

export const patchFollowTargetIdUsecase = async (
  r: FollowRepository,
  ur: UserProfileRepository,
  userId: string,
  targetId: string
) => {
  // ユーザーが存在するか確認する
  const user = await ur.FindByID(userId);
  if (!user) {
    throw new Error("user not found");
  }

  const target = await ur.FindByID(targetId);
  if (!target) {
    throw new Error("target not found");
  }

  const follow1 = await r.FindFollowByUserIdAndTargetId(userId, targetId);
  if (!follow1) {
    throw new Error("not requested");
  }
  if (follow1.status === "friend") {
    throw new Error("already followed");
  }

  const follow2 = await r.FindFollowByUserIdAndTargetId(targetId, userId);
  if (!follow2) {
    throw new Error("not requested");
  }
  if (follow2.status === "friend") {
    throw new Error("already followed");
  }

  follow1.status = "friend";
  follow2.status = "friend";

  // フォロー状態にする
  await r.Store(follow1);
  await r.Store(follow2);
};
