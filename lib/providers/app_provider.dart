// lib/providers/app_provider.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/target_app.dart';
import '../models/interception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_config.dart';

class AppProvider extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  
  List<TargetApp> _targetApps = [];
  List<Interception> _interceptions = [];
  bool _isLoading = false;
  int _todayInterceptions = 0;
  int _todayMinutesSaved = 0;

  List<TargetApp> get targetApps => _targetApps;
  List<Interception> get interceptions => _interceptions;
  bool get isLoading => _isLoading;
  int get todayInterceptions => _todayInterceptions;
  int get todayMinutesSaved => _todayMinutesSaved;

  Future<void> loadTargetApps(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _supabase
          .from(SupabaseConfig.targetAppsTable)
          .select()
          .eq('user_id', userId);
      
      _targetApps = (response as List)
          .map((json) => TargetApp.fromJson(json))
          .toList();
    } catch (e) {
      _targetApps = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addTargetApp(TargetApp app) async {
    try {
      await _supabase
          .from(SupabaseConfig.targetAppsTable)
          .insert(app.toJson());
      
      _targetApps.add(app);
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }

  Future<void> removeTargetApp(String appId) async {
    try {
      await _supabase
          .from(SupabaseConfig.targetAppsTable)
          .delete()
          .eq('id', appId);
      
      _targetApps.removeWhere((app) => app.id == appId);
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }

  Future<void> loadTodayInterceptions(String userId) async {
    try {
      final today = DateTime.now();
      final startOfDay = DateTime(today.year, today.month, today.day);
      
      final response = await _supabase
          .from(SupabaseConfig.interceptionsTable)
          .select()
          .eq('user_id', userId)
          .gte('timestamp', startOfDay.toIso8601String());
      
      _interceptions = (response as List)
          .map((json) => Interception.fromJson(json))
          .toList();
      
      _todayInterceptions = _interceptions.length;
      _todayMinutesSaved = _interceptions
          .fold(0, (sum, i) => sum + i.resistedMinutes);
      
      notifyListeners();
    } catch (e) {
      _interceptions = [];
      _todayInterceptions = 0;
      _todayMinutesSaved = 0;
    }
  }

  Future<void> addInterception(Interception interception) async {
    try {
      await _supabase
          .from(SupabaseConfig.interceptionsTable)
          .insert(interception.toJson());
      
      _interceptions.add(interception);
      _todayInterceptions++;
      _todayMinutesSaved += interception.resistedMinutes;
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }
}
