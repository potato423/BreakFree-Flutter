// lib/screens/legal/privacy_policy_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/language_provider.dart';
import '../../config/theme.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>();
    final isEnglish = lang.isEnglish;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEnglish ? 'Privacy Policy' : '隐私政策'),
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
              isEnglish ? '1. Introduction' : '1. 简介',
              isEnglish
                ? 'BreakFree ("we", "our", or "us") respects your privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application.'
                : 'BreakFree（"我们"或"我们的"）尊重您的隐私。本隐私政策说明了我们如何收集、使用、披露和保护您使用我们的移动应用程序时的信息。',
            ),
            _buildSection(
              isEnglish ? '2. Information We Collect' : '2. 我们收集的信息',
              isEnglish
                ? 'We collect information you provide directly, such as your email address and profile information. We also collect usage data to improve our services.'
                : '我们收集您直接提供的信息，例如您的邮箱地址和个人资料信息。我们还收集使用数据以改进我们的服务。',
            ),
            _buildSection(
              isEnglish ? '3. How We Use Your Information' : '3. 我们如何使用您的信息',
              isEnglish
                ? 'We use your information to provide, maintain, and improve our services. We may also use your information to communicate with you about updates or promotional content.'
                : '我们使用您的信息来提供、维护和改进我们的服务。我们也可能使用您的信息与您沟通有关更新或促销内容。',
            ),
            _buildSection(
              isEnglish ? '4. Data Security' : '4. 数据安全',
              isEnglish
                ? 'We implement appropriate security measures to protect your personal information against unauthorized access, alteration, disclosure, or destruction.'
                : '我们实施适当的安全措施，以保护您的个人信息免受未经授权的访问、更改、披露或破坏。',
            ),
            _buildSection(
              isEnglish ? '5. Third-Party Services' : '5. 第三方服务',
              isEnglish
                ? 'We use Supabase for backend services. Their privacy policy applies to how they handle your data.'
                : '我们使用 Supabase 作为后端服务。他们的隐私政策适用于他们如何处理您的数据。',
            ),
            _buildSection(
              isEnglish ? '6. Your Rights' : '6. 您的权利',
              isEnglish
                ? 'You have the right to access, correct, or delete your personal information. Contact us to exercise these rights.'
                : '您有权访问、更正或删除您的个人信息。请联系我们行使这些权利。',
            ),
            _buildSection(
              isEnglish ? '7. Contact Us' : '7. 联系我们',
              isEnglish
                ? 'If you have questions about this Privacy Policy, please contact us at support@breakfree.app'
                : '如果您对本隐私政策有任何疑问，请通过 support@breakfree.app 联系我们',
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
