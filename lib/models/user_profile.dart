// lib/models/user_profile.dart
class UserProfile {
  final String id;
  final String? email;
  final String subscriptionTier;
  final int streakDays;
  final int totalSavedMinutes;
  final DateTime createdAt;
  final DateTime lastActiveAt;

  UserProfile({
    required this.id,
    this.email,
    this.subscriptionTier = 'Free',
    this.streakDays = 0,
    this.totalSavedMinutes = 0,
    required this.createdAt,
    required this.lastActiveAt,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] ?? json['uid'] ?? '',
      email: json['email'],
      subscriptionTier: json['subscription_tier'] ?? 'Free',
      streakDays: json['streak_days'] ?? 0,
      totalSavedMinutes: json['total_saved_minutes'] ?? 0,
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : DateTime.now(),
      lastActiveAt: json['last_active_at'] != null 
          ? DateTime.parse(json['last_active_at']) 
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': id,
      'email': email,
      'subscription_tier': subscriptionTier,
      'streak_days': streakDays,
      'total_saved_minutes': totalSavedMinutes,
    };
  }

  UserProfile copyWith({
    String? id,
    String? email,
    String? subscriptionTier,
    int? streakDays,
    int? totalSavedMinutes,
    DateTime? createdAt,
    DateTime? lastActiveAt,
  }) {
    return UserProfile(
      id: id ?? this.id,
      email: email ?? this.email,
      subscriptionTier: subscriptionTier ?? this.subscriptionTier,
      streakDays: streakDays ?? this.streakDays,
      totalSavedMinutes: totalSavedMinutes ?? this.totalSavedMinutes,
      createdAt: createdAt ?? this.createdAt,
      lastActiveAt: lastActiveAt ?? this.lastActiveAt,
    );
  }
}
