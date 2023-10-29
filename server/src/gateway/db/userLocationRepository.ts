import { SupabaseClient } from "@supabase/supabase-js";
import { UserLocation } from "../../domain/model/userLocation";
import { UserLocationRepository } from "../../domain/repository/userLocationRepository";
import { Database } from "../../infrastructure/db/supabase.types";

export class userLocationRepository implements UserLocationRepository {
  supabase: SupabaseClient<Database>;

  constructor(supabase: SupabaseClient<Database>) {
    this.supabase = supabase;
  }

  async Store(model: UserLocation): Promise<UserLocation> {
    const { data, error } = await this.supabase
      .from("user_locations")
      .upsert({
        id: model.id,
        location_name: model.locationName,
        is_custom: model.isCustom,
        created_at: model.createdAt.toLocaleString(),
        updated_at: model.updatedAt.toLocaleString(),
      })
      .select("*")
      .single();

    if (error) {
      throw error;
    }

    return new UserLocation(
      data.id,
      data.location_name,
      data.is_custom,
      new Date(data.created_at),
      new Date(data.updated_at)
    );
  }

  async FindByUserID(userID: string): Promise<UserLocation | undefined> {
    const { data, error } = await this.supabase
      .from("user_locations")
      .select("*")
      .eq("user_id", userID)
      .single();

    if (error) {
      throw error;
    }

    if (!data) {
      return undefined;
    }

    return new UserLocation(
      data.id,
      data.location_name,
      data.is_custom,
      new Date(data.created_at),
      new Date(data.updated_at)
    );
  }
}
