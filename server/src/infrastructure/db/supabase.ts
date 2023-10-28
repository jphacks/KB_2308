import { SupabaseClient, createClient } from "@supabase/supabase-js";
import { Database } from "./supabase.types";

const globalForSupabase = globalThis as unknown as {
  supabase: SupabaseClient<Database> | undefined;
};

export const supabase =
  globalForSupabase.supabase ??
  createClient<Database>(
    "https://jbigttrcudubidekcqnu.supabase.co",
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpiaWd0dHJjdWR1YmlkZWtjcW51Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY5ODMyNzMzNCwiZXhwIjoyMDEzOTAzMzM0fQ.QFtAKNP_M-gmbALZIY00IN8cnPkzBPT1oE6OTV_Cf_w"
  );

globalForSupabase.supabase = supabase;
