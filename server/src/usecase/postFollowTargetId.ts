import { Follow } from "../domain/model/follow";
import { FollowRepository } from "../domain/repository/followRepository";
import { UserProfileRepository } from "../domain/repository/userProfileRepository";

export const postFollowTargetIdUsecase = async (
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

  // フォロー一覧を出す
  const follow1 = await r.FindFollowsByUserAndStatus(user.id, "friend");
  const follow2 = await r.FindFollowsByUserAndStatus(target.id, "friend");
  // フォローしていたらエラーを返す
  if (follow1.some((c) => c.targetUserID === target.id)) {
    throw new Error("already followed");
  }
  if (follow2.some((c) => c.targetUserID === user.id)) {
    throw new Error("already followed");
  }

  // フォロー申請を作成する
  await r.Store(new Follow(user.id, target.id, "requesting"));
  await r.Store(new Follow(target.id, user.id, "pending"));
};
