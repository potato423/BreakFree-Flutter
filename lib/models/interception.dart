// lib/models/interception.dart
class Interception {
  final String id;
  final String userId;
  final String appName;
  final DateTime timestamp;
  final int resistedMinutes;
  final bool wasSuccessful;

  Interception({
    required this.id,
    required this.userId,
    required this.appName,
    required this.timestamp,
    this.resistedMinutes = 0,
    this.wasSuccessful = true,
  });

  factory Interception.fromJson(Map<String, dynamic> json) {
    return Interception(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      appName: json['app_name'] ?? '',
      timestamp: json['timestamp'] != null 
          ? DateTime.parse(json['timestamp']) 
          : DateTime.now(),
      resistedMinutes: json['resisted_minutes'] ?? 0,
      wasSuccessful: json['was_successful'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'app_name': appName,
      'timestamp': timestamp.toIso8601String(),
      'resisted_minutes': resistedMinutes,
      'was_successful': wasSuccessful,
    };
  }
}
