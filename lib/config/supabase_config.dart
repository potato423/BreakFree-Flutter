// lib/config/supabase_config.dart
class SupabaseConfig {
  // Replace with your actual Supabase credentials
  static const String supabaseUrl = 'https://uqtugnimwtgparadklhj.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVxdHVnbmltd3RnYXJhZGtsaGoiLCJyb2xlIjoiYW5vbiIsImlhdCI6MTY0MjU0MjQwMCwiZXhwIjoxOTU4MTE4NDAwfQ.H9jR9R7R3R8V9jK5xY5xY5xY5xY5xY5xY5xY5xY5';
  
  // Table names
  static const String profilesTable = 'profiles';
  static const String interceptionsTable = 'interceptions';
  static const String targetAppsTable = 'target_apps';
  static const String subscriptionsTable = 'subscriptions';
}
