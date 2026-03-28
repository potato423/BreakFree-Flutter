// lib/providers/auth_provider.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_profile.dart';
import '../config/supabase_config.dart';

class AuthProvider extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  
  User? _user;
  UserProfile? _profile;
  bool _isLoading = true;
  String? _error;

  User? get user => _user;
  UserProfile? get profile => _profile;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _user != null;
  String? get error => _error;

  AuthProvider() {
    _init();
  }

  Future<void> _init() async {
    _user = _supabase.auth.currentUser;
    if (_user != null) {
      await _fetchProfile();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> signUp(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );
      
      if (response.user != null) {
        _user = response.user;
        await _createProfile();
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signIn(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      
      if (response.user != null) {
        _user = response.user;
        await _fetchProfile();
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signInAnonymously() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Use anonymous sign-in if enabled
      final response = await _supabase.auth.signInWithPassword(
        email: 'anonymous@breakfree.app',
        password: 'anonymous_user_123',
      );
      
      if (response.user != null) {
        _user = response.user;
        await _fetchProfile();
      }
    } catch (e) {
      // If anonymous not enabled, create guest profile locally
      _user = null;
      _profile = UserProfile(
        id: 'guest_${DateTime.now().millisecondsSinceEpoch}',
        email: null,
        createdAt: DateTime.now(),
        lastActiveAt: DateTime.now(),
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signInWithGoogle() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'breakfree://login-callback',
      );
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signInWithApple() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _supabase.auth.signInWithOAuth(
        OAuthProvider.apple,
        redirectTo: 'breakfree://login-callback',
      );
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
    _user = null;
    _profile = null;
    notifyListeners();
  }

  Future<void> _fetchProfile() async {
    if (_user == null) return;

    try {
      final response = await _supabase
          .from(SupabaseConfig.profilesTable)
          .select()
          .eq('uid', _user!.id)
          .maybeSingle();

      if (response != null) {
        _profile = UserProfile.fromJson(response);
      } else {
        await _createProfile();
      }
    } catch (e) {
      // Profile might not exist, create one
      await _createProfile();
    }
  }

  Future<void> _createProfile() async {
    if (_user == null) return;

    try {
      final newProfile = {
        'uid': _user!.id,
        'email': _user!.email,
        'subscription_tier': 'Free',
        'streak_days': 0,
        'total_saved_minutes': 0,
        'created_at': DateTime.now().toIso8601String(),
        'last_active_at': DateTime.now().toIso8601String(),
      };

      await _supabase
          .from(SupabaseConfig.profilesTable)
          .insert(newProfile);

      _profile = UserProfile.fromJson(newProfile);
    } catch (e) {
      // Profile might already exist
    }
  }

  Future<void> updateProfile(UserProfile profile) async {
    if (_user == null) return;

    try {
      await _supabase
          .from(SupabaseConfig.profilesTable)
          .update(profile.toJson())
          .eq('uid', _user!.id);
      
      _profile = profile;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> updateStreak() async {
    if (_profile == null || _user == null) return;

    final newStreak = _profile!.streakDays + 1;
    final updatedProfile = _profile!.copyWith(
      streakDays: newStreak,
      lastActiveAt: DateTime.now(),
    );

    await updateProfile(updatedProfile);
  }
}
