import { SupabaseClient } from "@supabase/supabase-js";
import { UserProfile } from "../../domain/model/userProfile";
import { UserProfileRepository } from "../../domain/repository/userProfileRepository";
import { Database } from "../../infrastructure/db/supabase.types";

export class userProfileRepository implements UserProfileRepository {
  supabase: SupabaseClient<Database>;

  constructor(supabase: SupabaseClient<Database>) {
    this.supabase = supabase;
  }

  async FindByID(id: string): Promise<UserProfile | undefined> {
    const { data, error } = await this.supabase
      .from("user_profiles")
      .select("*")
      .eq("id", id)
      .single();

    if (error) {
      throw error;
    }

    if (!data) {
      return undefined;
    }

    return new UserProfile(
      data.id,
      data.user_id,
      data.name,
      data.image_url,
      new Date(data.created_at),
      new Date(data.updated_at)
    );
  }

  async FindByUserID(userID: string): Promise<UserProfile | undefined> {
    const { data, error } = await this.supabase
      .from("user_profiles")
      .select("*")
      .eq("user_id", userID)
      .single();

    if (error) {
      throw error;
    }

    if (!data) {
      return undefined;
    }

    return new UserProfile(
      data.id,
      data.user_id,
      data.name,
      data.image_url,
      new Date(data.created_at),
      new Date(data.updated_at)
    );
  }

  async Store(model: UserProfile): Promise<UserProfile> {
    const { data, error } = await this.supabase
      .from("user_profiles")
      .upsert({
        id: model.id,
        user_id: model.userID,
        name: model.name,
        image_url: model.imageUrl,
        created_at: model.createdAt.toLocaleString(),
        updated_at: model.updatedAt.toLocaleString(),
      })
      .select("*")
      .single();

    if (error) {
      throw error;
    }

    return new UserProfile(
      data.id,
      data.user_id,
      data.name,
      data.image_url,
      new Date(data.created_at),
      new Date(data.updated_at)
    );
  }
}
