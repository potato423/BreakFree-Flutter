// lib/screens/legal/terms_of_service_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/language_provider.dart';
import '../../config/theme.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>();
    final isEnglish = lang.isEnglish;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEnglish ? 'Terms of Service' : '服务条款'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isEnglish 
                ? 'Last Updated: March 2026'
                : '最后更新：2026年3月',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            _buildSection(
              isEnglish ? '1. Acceptance of Terms' : '1. 接受条款',
              isEnglish
                ? 'By downloading and using BreakFree, you agree to be bound by these Terms of Service. If you do not agree to these terms, please do not use our app.'
                : '通过下载和使用 BreakFree，您同意受这些服务条款的约束。如果您不同意这些条款，请不要使用我们的应用。',
            ),
            _buildSection(
              isEnglish ? '2. Use License' : '2. 使用许可',
              isEnglish
                ? 'BreakFree grants you a limited, non-exclusive, non-transferable license to use our app for personal, non-commercial purposes.'
                : 'BreakFree 授予您有限、非排他性、不可转让的许可，仅用于个人非商业目的使用我们的应用。',
            ),
            _buildSection(
              isEnglish ? '3. User Account' : '3. 用户账户',
              isEnglish
                ? 'You are responsible for maintaining the confidentiality of your account and password. You agree to accept responsibility for all activities that occur under your account.'
                : '您有责任维护您的账户和密码的机密性。您同意对在您的账户下发生的所有活动承担责任。',
            ),
            _buildSection(
              isEnglish ? '4. Prohibited Uses' : '4. 禁止用途',
              isEnglish
                ? 'You may not use our app for any illegal purpose or in any way that could damage, disable, or impair our services.'
                : '您不得将我们的应用用于任何非法目的或以任何可能损害、禁用或损害我们服务的方式使用。',
            ),
            _buildSection(
              isEnglish ? '5. Limitation of Liability' : '5. 责任限制',
              isEnglish
                ? 'BreakFree shall not be liable for any indirect, incidental, or consequential damages arising from your use of the app.'
                : 'BreakFree 对因您使用本应用而产生的任何间接、偶然或后果性损害不承担责任。',
            ),
            _buildSection(
              isEnglish ? '6. Changes to Terms' : '6. 条款变更',
              isEnglish
                ? 'We reserve the right to modify these terms at any time. Your continued use of the app after changes constitutes acceptance of the new terms.'
                : '我们保留随时修改这些条款的权利。您在更改后继续使用本应用即表示接受新条款。',
            ),
            _buildSection(
              isEnglish ? '7. Contact' : '7. 联系方式',
              isEnglish
                ? 'For questions about these Terms of Service, please contact us at support@breakfree.app'
                : '如对这些服务条款有疑问，请通过 support@breakfree.app 联系我们',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 15,
              height: 1.6,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
