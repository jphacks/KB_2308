import { zValidator } from "@hono/zod-validator";
import { User } from "@supabase/supabase-js";
import { Hono, MiddlewareHandler } from "hono";
import { HTTPException } from "hono/http-exception";
import { z } from "zod";
import { FollowRepository } from "./domain/repository/followRepository";
import { UserLocationRepository } from "./domain/repository/userLocationRepository";
import { UserProfileRepository } from "./domain/repository/userProfileRepository";
import { followRepository } from "./gateway/db/followRepository";
import { userLocationRepository } from "./gateway/db/userLocationRepository";
import { userProfileRepository } from "./gateway/db/userProfileRepository";
import { supabase } from "./infrastructure/db/supabase";
import { parseBearerToken } from "./libs/parseBearerToken";
import { deleteFollowTargetIdUsecase } from "./usecase/deleteFollowTargetId";
import { getFollowMeUsercase } from "./usecase/getFollowMe";
import { getFollowRequestMe } from "./usecase/getFollowRequestMe";
import { getLocationUserIdUsecase } from "./usecase/getLocationUserId";
import { getProfileMeUsecase } from "./usecase/getProfileMe";
import { getProfileSearchUserIdUsecase } from "./usecase/getProfileSearchUserId";
import { patchFollowTargetIdUsecase } from "./usecase/patchFollowTargetId";
import { postFollowTargetIdUsecase } from "./usecase/postFollowTargetId";
import { postProfileUsecase } from "./usecase/postProfile";
import { putLocationUsecase } from "./usecase/putLocation";
import { putProfileUsecase } from "./usecase/putProfile";

// DIオブジェクト生成
const followRepositoryObject: FollowRepository = new followRepository(supabase);
const userLocationRepositoryObject: UserLocationRepository =
  new userLocationRepository(supabase);
const userProfileRepositoryObject: UserProfileRepository =
  new userProfileRepository(supabase);

type Variables = {
  user: User;
};
const app = new Hono<{ Variables: Variables }>();

const authMiddleWare: MiddlewareHandler<{
  Variables: Variables;
}> = async (c, next) => {
  const token = c.req.header("Authorization");
  //   Bearerパース
  const jwt = parseBearerToken(token);
  if (jwt instanceof Error) {
    throw new HTTPException(401, { message: jwt.message });
  }

  const {
    data: { user },
    error,
  } = await supabase.auth.getUser(jwt);
  if (error) {
    throw new HTTPException(401, { message: error.message });
  }
  if (!user) {
    throw new HTTPException(401, { message: "User not found" });
  }

  c.set("user", user);
  await next();
};

app.use("*", authMiddleWare);

app.get("/", (c) => c.text("Hello Hono!"));

/** プロフィールのget, post, put, delete */
// 自分のプロフィールを見る
app.post(
  "/profile",
  zValidator(
    "json",
    z.object({
      user_id: z.string().uuid(),
      name: z.string().min(1).max(20),
      image_url: z.string().url(),
    })
  ),
  async (c) => {
    const body = c.req.valid("json");
    const profile = await postProfileUsecase(
      userProfileRepositoryObject,
      body.user_id,
      body.name,
      body.image_url
    );

    return c.json({
      user_id: profile.userID,
      name: profile.name,
      image_url: profile.imageUrl,
      created_at: profile.createdAt,
      updated_at: profile.updatedAt,
    });
  }
);
app.put(
  "/profile",
  zValidator(
    "json",
    z.object({
      new_name: z.string().min(1),
      new_user_id: z.string().min(1),
      new_image_url: z.string().url(),
    })
  ),
  async (c) => {
    const user = c.get("user");

    const body = c.req.valid("json");
    const profile = await putProfileUsecase(
      userProfileRepositoryObject,
      user.id,
      body.new_name,
      body.new_user_id,
      body.new_image_url
    );

    return c.json({
      id: profile.id,
      user_id: profile.userID,
      name: profile.name,
      image_url: profile.imageUrl,
      created_at: profile.createdAt,
      updated_at: profile.updatedAt,
    });
  }
);
app.get("/profile/me", async (c) => {
  const user = c.get("user");

  const profile = await getProfileMeUsecase(
    userProfileRepositoryObject,
    user.id
  );

  if (!profile) {
    throw new HTTPException(404, { message: "Profile not found" });
  }

  return c.json({
    id: profile.id,
    user_id: profile.userID,
    name: profile.name,
    image_url: profile.imageUrl,
    created_at: profile.createdAt,
    updated_at: profile.updatedAt,
  });
});

/** フレンド申請のため、user_profiles.user_idからプロフィールを検索 */
app.get(
  "/profile/search/:userId",
  zValidator(
    "param",
    z.object({
      userId: z.string().uuid(),
    })
  ),
  async (c) => {
    const { userId } = c.req.valid("param");

    const profile = await getProfileSearchUserIdUsecase(
      userProfileRepositoryObject,
      userId
    );
    if (!profile) {
      throw new HTTPException(404, { message: "Profile not found" });
    }

    return c.json({
      id: profile.id,
      user_id: profile.userID,
      name: profile.name,
      image_url: profile.imageUrl,
      created_at: profile.createdAt,
      updated_at: profile.updatedAt,
    });
  }
);

/** 今いる場所のget, create or update */
app.put(
  "/location",
  zValidator(
    "json",
    z.object({
      location_name: z.string().min(1).max(20),
      is_custom: z.boolean(),
    })
  ),
  async (c) => {
    const user = c.get("user");

    const body = c.req.valid("json");

    const location = await putLocationUsecase(
      userLocationRepositoryObject,
      user.id,
      body.location_name,
      body.is_custom
    );

    return c.json({
      id: location.id,
      location_name: location.locationName,
      is_custom: location.isCustom,
      created_at: location.createdAt,
      updated_at: location.updatedAt,
    });
  }
);
// 該当ユーザーの場所を取得
app.get(
  "/location/:userId",
  zValidator(
    "param",
    z.object({
      userId: z.string().uuid(),
    })
  ),
  async (c) => {
    const { userId } = c.req.valid("param");

    const location = await getLocationUserIdUsecase(
      userLocationRepositoryObject,
      userId
    );

    if (!location) {
      throw new HTTPException(404, { message: "Location not found" });
    }

    return c.json({
      id: location.id,
      location_name: location.locationName,
      is_custom: location.isCustom,
      created_at: location.createdAt,
      updated_at: location.updatedAt,
    });
  }
);

/** フォロー申請のget, post, put, delete  */
// 自分とフォロー関係がある人一覧を取得
app.get("/follow/me", async (c) => {
  const user = c.get("user");

  const users = await getFollowMeUsercase(followRepositoryObject, user.id);

  return c.json(
    users.map((u) => ({
      id: u.id,
      user_id: u.userID,
      name: u.name,
      image_url: u.imageUrl,
      created_at: u.createdAt,
      updated_at: u.updatedAt,
    }))
  );
});
// 自分に来ているフォロー申請を取得
app.get("/follow/request/me", async (c) => {
  const user = c.get("user");

  const users = await getFollowRequestMe(followRepositoryObject, user.id);

  return c.json(
    users.map((u) => ({
      id: u.id,
      user_id: u.userID,
      name: u.name,
      image_url: u.imageUrl,
      created_at: u.createdAt,
      updated_at: u.updatedAt,
    }))
  );
});
// 申請
app.post(
  "/follow/:targetId",
  zValidator(
    "json",
    z.object({
      target_id: z.string().uuid(),
    })
  ),
  async (c) => {
    const user = c.get("user");

    const body = c.req.valid("json");

    return await postFollowTargetIdUsecase(
      followRepositoryObject,
      userProfileRepositoryObject,
      user.id,
      body.target_id
    );
  }
);
// フレンドステータス更新; 承認時に使用
app.patch(
  "/follow/:targetId",
  zValidator(
    "param",
    z.object({
      targetId: z.string().uuid(),
    })
  ),
  async (c) => {
    const user = c.get("user");

    const { targetId } = c.req.valid("param");

    return await patchFollowTargetIdUsecase(
      followRepositoryObject,
      userProfileRepositoryObject,
      user.id,
      targetId
    );
  }
);
// フレンド解除、拒否時に使用
app.delete(
  "/follow/:targetId",
  zValidator(
    "param",
    z.object({
      targetId: z.string().uuid(),
    })
  ),
  async (c) => {
    const user = c.get("user");

    const { targetId } = c.req.valid("param");

    return await deleteFollowTargetIdUsecase(
      followRepositoryObject,
      user.id,
      targetId
    );
  }
);

export default app;
