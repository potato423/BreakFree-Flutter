// lib/models/target_app.dart
class TargetApp {
  final String id;
  final String userId;
  final String appName;
  final String? bundleId;
  final String category;
  final int dailyLimitMinutes;
  final bool isBlocked;
  final DateTime createdAt;

  TargetApp({
    required this.id,
    required this.userId,
    required this.appName,
    this.bundleId,
    required this.category,
    this.dailyLimitMinutes = 60,
    this.isBlocked = false,
    required this.createdAt,
  });

  factory TargetApp.fromJson(Map<String, dynamic> json) {
    return TargetApp(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      appName: json['app_name'] ?? '',
      bundleId: json['bundle_id'],
      category: json['category'] ?? 'social',
      dailyLimitMinutes: json['daily_limit_minutes'] ?? 60,
      isBlocked: json['is_blocked'] ?? false,
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'app_name': appName,
      'bundle_id': bundleId,
      'category': category,
      'daily_limit_minutes': dailyLimitMinutes,
      'is_blocked': isBlocked,
    };
  }
}

// App categories
class AppCategory {
  static const String social = 'social';
  static const String entertainment = 'entertainment';
  static const String game = 'game';
  static const String news = 'news';
  static const String shopping = 'shopping';
  static const String other = 'other';

  static String getName(String category) {
    switch (category) {
      case social:
        return 'Social';
      case entertainment:
        return 'Entertainment';
      case game:
        return 'Games';
      case news:
        return 'News';
      case shopping:
        return 'Shopping';
      default:
        return 'Other';
    }
  }

  static String getIcon(String category) {
    switch (category) {
      case social:
        return 'people';
      case entertainment:
        return 'movie';
      case game:
        return 'sports_esports';
      case news:
        return 'newspaper';
      case shopping:
        return 'shopping_bag';
      default:
        return 'apps';
    }
  }
}
