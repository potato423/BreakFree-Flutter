// lib/providers/language_provider.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  static const String _languageKey = 'app_language';
  
  Locale _locale = const Locale('en');
  
  Locale get locale => _locale;
  bool get isEnglish => _locale.languageCode == 'en';
  bool get isChinese => _locale.languageCode == 'zh';

  LanguageProvider() {
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_languageKey) ?? 'en';
    _locale = Locale(languageCode);
    notifyListeners();
  }

  Future<void> setLanguage(String languageCode) async {
    if (_locale.languageCode == languageCode) return;
    
    _locale = Locale(languageCode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, languageCode);
    notifyListeners();
  }

  Future<void> toggleLanguage() async {
    await setLanguage(isEnglish ? 'zh' : 'en');
  }

  String getString(String english, String chinese) {
    return isEnglish ? english : chinese;
  }
}

// Translations
class AppTranslations {
  static const Map<String, Map<String, String>> translations = {
    // Common
    'continue': {'en': 'Continue', 'zh': '继续'},
    'skip': {'en': 'Skip', 'zh': '跳过'},
    'next': {'en': 'Next', 'zh': '下一步'},
    'done': {'en': 'Done', 'zh': '完成'},
    'save': {'en': 'Save', 'zh': '保存'},
    'cancel': {'en': 'Cancel', 'zh': '取消'},
    'confirm': {'en': 'Confirm', 'zh': '确认'},
    'delete': {'en': 'Delete', 'zh': '删除'},
    'edit': {'en': 'Edit', 'zh': '编辑'},
    'loading': {'en': 'Loading...', 'zh': '加载中...'},
    'error': {'en': 'Error', 'zh': '错误'},
    'success': {'en': 'Success', 'zh': '成功'},
    
    // Auth
    'sign_in': {'en': 'Sign In', 'zh': '登录'},
    'sign_up': {'en': 'Sign Up', 'zh': '注册'},
    'sign_out': {'en': 'Sign Out', 'zh': '退出登录'},
    'email': {'en': 'Email', 'zh': '邮箱'},
    'password': {'en': 'Password', 'zh': '密码'},
    'confirm_password': {'en': 'Confirm Password', 'zh': '确认密码'},
    'forgot_password': {'en': 'Forgot Password?', 'zh': '忘记密码？'},
    'dont_have_account': {"en": "Don't have an account?", 'zh': '没有账号？'},
    'already_have_account': {'en': 'Already have an account?', 'zh': '已有账号？'},
    'or_continue_with': {'en': 'Or continue with', 'zh': '或使用以下方式继续'},
    'continue_as_guest': {'en': 'Continue as Guest', 'zh': '游客模式'},
    
    // Onboarding
    'onboarding_title_1': {'en': 'Break Free from Phone Addiction', 'zh': '摆脱手机成瘾'},
    'onboarding_desc_1': {'en': 'Take control of your digital life and build healthier habits', 'zh': '掌控你的数字生活，建立更健康的习惯'},
    'onboarding_title_2': {'en': 'Track Your Progress', 'zh': '追踪你的进度'},
    'onboarding_desc_2': {'en': 'See how much time you save each day with detailed statistics', 'zh': '通过详细的统计数据了解你每天节省了多少时间'},
    'onboarding_title_3': {'en': 'Stay Motivated', 'zh': '保持动力'},
    'onboarding_desc_3': {'en': 'Build streaks and earn rewards as you improve', 'zh': '随着你的进步，建立连续记录并获得奖励'},
    
    // Home
    'home': {'en': 'Home', 'zh': '首页'},
    'stats': {'en': 'Stats', 'zh': '统计'},
    'settings': {'en': 'Settings', 'zh': '设置'},
    'todays_progress': {"en": "Today's Progress", 'zh': '今日进度'},
    'time_saved': {'en': 'Time Saved', 'zh': '节省时间'},
    'interceptions': {'en': 'Interceptions', 'zh': '拦截次数'},
    'current_streak': {'en': 'Current Streak', 'zh': '当前连续'},
    'days': {'en': 'days', 'zh': '天'},
    'minutes': {'en': 'min', 'zh': '分钟'},
    'target_apps': {'en': 'Target Apps', 'zh': '目标应用'},
    'no_target_apps': {'en': 'No target apps yet', 'zh': '还没有目标应用'},
    'add_app': {'en': 'Add App', 'zh': '添加应用'},
    
    // Settings
    'language': {'en': 'Language', 'zh': '语言'},
    'english': {'en': 'English', 'zh': 'English'},
    'chinese': {'en': '中文', 'zh': '中文'},
    'notifications': {'en': 'Notifications', 'zh': '通知'},
    'subscription': {'en': 'Subscription', 'zh': '订阅'},
    'privacy_policy': {'en': 'Privacy Policy', 'zh': '隐私政策'},
    'terms_of_service': {'en': 'Terms of Service', 'zh': '服务条款'},
    'version': {'en': 'Version', 'zh': '版本'},
    'about': {'en': 'About', 'zh': '关于'},
    
    // Interception
    'caught_in_act': {'en': 'Caught in the act!', 'zh': '被发现啦！'},
    'resist_temptation': {'en': 'Resist the temptation', 'zh': '抵抗诱惑'},
    'you_saved': {'en': 'You saved', 'zh': '你节省了'},
    'great_job': {'en': 'Great job!', 'zh': '做得好！'},
    'keep_going': {'en': 'Keep going!', 'zh': '继续加油！'},
    
    // Breathing
    'breathing_exercise': {'en': 'Breathing Exercise', 'zh': '呼吸练习'},
    'breathe_in': {'en': 'Breathe In', 'zh': '吸气'},
    'hold': {'en': 'Hold', 'zh': '屏住'},
    'breathe_out': {'en': 'Breathe Out', 'zh': '呼气'},
  };

  static String t(String key, String languageCode) {
    return translations[key]?[languageCode] ?? key;
  }
}
