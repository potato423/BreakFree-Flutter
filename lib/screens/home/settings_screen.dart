// lib/screens/home/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/language_provider.dart';
import '../../config/theme.dart';
import '../legal/privacy_policy_screen.dart';
import '../legal/terms_of_service_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final lang = context.watch<LanguageProvider>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lang.getString('Settings', '设置'),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 24),
              // Account Section
              _buildSectionTitle(lang.getString('Account', '账户')),
              const SizedBox(height: 12),
              _buildSettingsCard([
                _buildSettingsItem(
                  icon: Icons.person_outline,
                  title: lang.getString('Profile', '个人资料'),
                  onTap: () {},
                ),
                _buildDivider(),
                _buildSettingsItem(
                  icon: Icons.workspace_premium_outlined,
                  title: lang.getString('Subscription', '订阅'),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.accentMint.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      auth.profile?.subscriptionTier ?? 'Free',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.accentMint,
                      ),
                    ),
                  ),
                  onTap: () {},
                ),
              ]),
              const SizedBox(height: 24),
              // Preferences Section
              _buildSectionTitle(lang.getString('Preferences', '偏好设置')),
              const SizedBox(height: 12),
              _buildSettingsCard([
                _buildSettingsItem(
                  icon: Icons.language,
                  title: lang.getString('Language', '语言'),
                  trailing: Text(
                    lang.isEnglish ? 'English' : '中文',
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  onTap: () => _showLanguageDialog(context),
                ),
                _buildDivider(),
                _buildSettingsItem(
                  icon: Icons.notifications_outlined,
                  title: lang.getString('Notifications', '通知'),
                  trailing: Switch(
                    value: true,
                    onChanged: (value) {},
                    activeColor: AppColors.primary,
                  ),
                  onTap: () {},
                ),
              ]),
              const SizedBox(height: 24),
              // Legal Section
              _buildSectionTitle(lang.getString('Legal', '法律')),
              const SizedBox(height: 12),
              _buildSettingsCard([
                _buildSettingsItem(
                  icon: Icons.privacy_tip_outlined,
                  title: lang.getString('Privacy Policy', '隐私政策'),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: AppColors.gray400,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PrivacyPolicyScreen(),
                      ),
                    );
                  },
                ),
                _buildDivider(),
                _buildSettingsItem(
                  icon: Icons.description_outlined,
                  title: lang.getString('Terms of Service', '服务条款'),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: AppColors.gray400,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const TermsOfServiceScreen(),
                      ),
                    );
                  },
                ),
              ]),
              const SizedBox(height: 24),
              // About Section
              _buildSectionTitle(lang.getString('About', '关于')),
              const SizedBox(height: 12),
              _buildSettingsCard([
                _buildSettingsItem(
                  icon: Icons.info_outline,
                  title: lang.getString('Version', '版本'),
                  trailing: const Text(
                    '1.0.0',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                  onTap: () {},
                ),
              ]),
              const SizedBox(height: 32),
              // Sign Out Button
              if (auth.isLoggedIn)
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => _showSignOutDialog(context, auth),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.error,
                      side: const BorderSide(color: AppColors.error),
                    ),
                    child: Text(lang.getString('Sign Out', '退出登录')),
                  ),
                ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
      ),
    );
  }

  Widget _buildSettingsCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.primary, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 1, indent: 72);
  }

  void _showLanguageDialog(BuildContext context) {
    final lang = context.read<LanguageProvider>();
    
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Text('🇺🇸', style: TextStyle(fontSize: 24)),
              title: const Text('English'),
              trailing: lang.isEnglish
                  ? const Icon(Icons.check, color: AppColors.primary)
                  : null,
              onTap: () {
                lang.setLanguage('en');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Text('🇨🇳', style: TextStyle(fontSize: 24)),
              title: const Text('中文'),
              trailing: lang.isChinese
                  ? const Icon(Icons.check, color: AppColors.primary)
                  : null,
              onTap: () {
                lang.setLanguage('zh');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showSignOutDialog(BuildContext context, AuthProvider auth) {
    final lang = context.read<LanguageProvider>();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(lang.getString('Sign Out', '退出登录')),
        content: Text(lang.getString(
          'Are you sure you want to sign out?',
          '确定要退出登录吗？'
        )),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(lang.getString('Cancel', '取消')),
          ),
          TextButton(
            onPressed: () {
              auth.signOut();
              Navigator.pop(context);
            },
            child: Text(
              lang.getString('Sign Out', '退出登录'),
              style: const TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
