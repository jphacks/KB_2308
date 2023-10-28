import { SupabaseClient } from "@supabase/supabase-js";
import { Follow, FollowStatus } from "../../domain/model/follow";
import { FollowRepository } from "../../domain/repository/followRepository";
import { Database } from "../../infrastructure/db/supabase.types";
import { UserProfile } from "../../domain/model/userProfile";

export class followRepository implements FollowRepository {
  supabase: SupabaseClient<Database>;

  constructor(supabase: SupabaseClient<Database>) {
    this.supabase = supabase;
  }

  async FindFollowByUserIdAndTargetId(
    userId: string,
    targetId: string
  ): Promise<Follow | undefined> {
    const { data, error } = await this.supabase
      .from("friendships")
      .select("*")
      .eq("user_id", userId)
      .eq("friend_id", targetId)
      .single();

    if (error) {
      throw error;
    }

    if (!data) {
      return undefined;
    }

    return new Follow(
      data.user_id,
      data.friend_id,
      data.status,
      new Date(data.created_at),
      new Date(data.updated_at)
    );
  }

  async FindFollowsByUserAndStatus(
    userId: string,
    status: FollowStatus
  ): Promise<UserProfile[]> {
    const { data, error } = await this.supabase
      .from("friendships")
      .select("*, user_profiles (*)")
      .eq("user_id", userId)
      .eq("status", status);

    if (error) {
      throw error;
    }

    if (!data) {
      return [];
    }

    return data.map((d) => {
      return new UserProfile(
        // 絶対に存在する
        d.user_profiles.at(0)?.id,
        d.user_profiles.at(0)?.user_id,
        d.user_profiles.at(0)?.name,
        d.user_profiles.at(0)?.image_url,
        new Date(d.user_profiles.at(0)?.created_at as string),
        new Date(d.user_profiles.at(0)?.updated_at as string)
      );
    });
  }

  async Store(follow: Follow): Promise<Follow> {
    const { data, error } = await this.supabase
      .from("friendships")
      .upsert({
        user_id: follow.userID,
        friend_id: follow.targetUserID,
        status: follow.status,
        created_at: follow.createdAt.toLocaleString(),
        updated_at: follow.updatedAt.toLocaleString(),
      })
      .select("*")
      .single();

    if (error) {
      throw error;
    }

    return new Follow(
      data.user_id,
      data.friend_id,
      data.status,
      new Date(data.created_at),
      new Date(data.updated_at)
    );
  }

  async Delete(follow: Follow): Promise<void> {
    const { error } = await this.supabase
      .from("friendships")
      .delete()
      .eq("user_id", follow.userID)
      .eq("friend_id", follow.targetUserID)
      .single();

    if (error) {
      throw error;
    }
  }
}
