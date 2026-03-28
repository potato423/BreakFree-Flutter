// lib/screens/home/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/language_provider.dart';
import '../../providers/app_provider.dart';
import '../../config/theme.dart';
import '../../models/target_app.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    final auth = context.read<AuthProvider>();
    final app = context.read<AppProvider>();
    
    if (auth.user != null) {
      app.loadTargetApps(auth.user!.id);
      app.loadTodayInterceptions(auth.user!.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final app = context.watch<AppProvider>();
    final lang = context.watch<LanguageProvider>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lang.getString('Good Morning', '早上好'),
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        auth.profile?.email ?? 'Guest',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.person_outline,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Today's Progress Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primaryLight,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lang.getString("Today's Progress", '今日进度'),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatItem(
                            '${app.todayMinutesSaved}',
                            lang.getString('min saved', '分钟节省'),
                            Icons.timer_outlined,
                          ),
                        ),
                        Expanded(
                          child: _buildStatItem(
                            '${app.todayInterceptions}',
                            lang.getString('interceptions', '次拦截'),
                            Icons.shield_outlined,
                          ),
                        ),
                        Expanded(
                          child: _buildStatItem(
                            '${auth.profile?.streakDays ?? 0}',
                            lang.getString('day streak', '天连续'),
                            Icons.local_fire_department_outlined,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Target Apps Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    lang.getString('Target Apps', '目标应用'),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () => _showAddAppDialog(),
                    icon: const Icon(Icons.add, size: 20),
                    label: Text(lang.getString('Add App', '添加')),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Apps List
              if (app.targetApps.isEmpty)
                _buildEmptyState(lang)
              else
                ...app.targetApps.map((app) => _buildAppCard(app, lang)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white70, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(LanguageProvider lang) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.gray50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gray200),
      ),
      child: Column(
        children: [
          Icon(
            Icons.apps_outlined,
            size: 48,
            color: AppColors.gray400,
          ),
          const SizedBox(height: 16),
          Text(
            lang.getString('No target apps yet', '还没有目标应用'),
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            lang.getString(
              'Add apps you want to limit',
              '添加你想要限制的应用'
            ),
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppCard(TargetApp app, LanguageProvider lang) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.accentCoral.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.apps,
              color: AppColors.accentCoral,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  app.appName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${app.dailyLimitMinutes} ${lang.getString('min/day', '分钟/天')}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _showInterceptionDialog(app),
            icon: const Icon(
              Icons.shield_outlined,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  void _showAddAppDialog() {
    final lang = context.read<LanguageProvider>();
    final app = context.read<AppProvider>();
    final auth = context.read<AuthProvider>();
    
    final nameController = TextEditingController();
    int selectedMinutes = 60;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lang.getString('Add Target App', '添加目标应用'),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: lang.getString('App Name', '应用名称'),
                    hintText: 'e.g., TikTok, Instagram',
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  lang.getString('Daily Limit', '每日限制'),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Slider(
                  value: selectedMinutes.toDouble(),
                  min: 15,
                  max: 180,
                  divisions: 11,
                  label: '$selectedMinutes min',
                  onChanged: (value) {
                    setState(() {
                      selectedMinutes = value.toInt();
                    });
                  },
                ),
                Center(
                  child: Text(
                    '$selectedMinutes ${lang.getString('minutes/day', '分钟/天')}',
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (nameController.text.isNotEmpty && auth.user != null) {
                        final newApp = TargetApp(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          userId: auth.user!.id,
                          appName: nameController.text,
                          dailyLimitMinutes: selectedMinutes,
                          createdAt: DateTime.now(),
                        );
                        app.addTargetApp(newApp);
                        Navigator.pop(context);
                      }
                    },
                    child: Text(lang.getString('Add', '添加')),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showInterceptionDialog(TargetApp app) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.warning_amber_rounded, color: AppColors.accentCoral),
            const SizedBox(width: 8),
            Text(app.appName),
          ],
        ),
        content: Text(
          context.read<LanguageProvider>().getString(
            'You tried to open this app! Great job resisting!',
            '你想打开这个应用！抵抗得很棒！'
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              context.read<LanguageProvider>().getString('Keep Going', '继续加油'),
            ),
          ),
        ],
      ),
    );
  }
}
