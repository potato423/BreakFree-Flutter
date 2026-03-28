// lib/screens/home/stats_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/language_provider.dart';
import '../../config/theme.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final lang = context.watch<LanguageProvider>();
    final profile = auth.profile;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                lang.getString('Statistics', '统计数据'),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 24),
              // Streak Card
              _buildStreakCard(profile?.streakDays ?? 0, lang),
              const SizedBox(height: 20),
              // Stats Grid
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      '${profile?.totalSavedMinutes ?? 0}',
                      lang.getString('Total Minutes Saved', '总共节省分钟'),
                      Icons.timer_outlined,
                      AppColors.accentMint,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard(
                      '${profile?.subscriptionTier ?? 'Free'}',
                      lang.getString('Current Plan', '当前套餐'),
                      Icons.workspace_premium_outlined,
                      AppColors.accentPurple,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Weekly Progress
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lang.getString('This Week', '本周'),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildWeekChart(lang),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Achievements
              Text(
                lang.getString('Achievements', '成就'),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              _buildAchievements(context, profile?.streakDays ?? 0, lang),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStreakCard(int streakDays, LanguageProvider lang) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accentCoral,
            AppColors.accentCoral.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.local_fire_department,
              size: 48,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$streakDays ${lang.getString('Day Streak', '天连续')}',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  lang.getString(
                    'Keep it up! You\'re doing great!',
                    '继续加油！你做得很好！'
                  ),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekChart(LanguageProvider lang) {
    final days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    final values = [45, 60, 30, 75, 50, 90, 65]; // Sample data

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(7, (index) {
        final isToday = index == DateTime.now().weekday - 1;
        return Column(
          children: [
            Container(
              width: 32,
              height: values[index].toDouble() * 0.8,
              decoration: BoxDecoration(
                color: isToday ? AppColors.primary : AppColors.gray200,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              days[index],
              style: TextStyle(
                fontSize: 12,
                fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                color: isToday ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildAchievements(BuildContext context, int streakDays, LanguageProvider lang) {
    final achievements = [
      {'icon': '🔥', 'title': '3 Day Streak', 'desc': '3天连续', 'unlocked': streakDays >= 3},
      {'icon': '🌟', 'title': '7 Day Streak', 'desc': '7天连续', 'unlocked': streakDays >= 7},
      {'icon': '💎', 'title': '30 Day Streak', 'desc': '30天连续', 'unlocked': streakDays >= 30},
      {'icon': '🏆', 'title': '100 Day Streak', 'desc': '100天连续', 'unlocked': streakDays >= 100},
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: achievements.map((a) {
        final unlocked = a['unlocked'] as bool;
        return Container(
          width: (MediaQuery.of(context).size.width - 52) / 2,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: unlocked ? AppColors.primary.withOpacity(0.1) : AppColors.gray50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: unlocked ? AppColors.primary : AppColors.gray200,
            ),
          ),
          child: Row(
            children: [
              Text(
                a['icon'] as String,
                style: TextStyle(
                  fontSize: 24,
                  color: unlocked ? null : Colors.grey,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      a['title'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: unlocked ? AppColors.textPrimary : AppColors.textLight,
                      ),
                    ),
                    Text(
                      a['desc'] as String,
                      style: TextStyle(
                        fontSize: 10,
                        color: unlocked ? AppColors.textSecondary : AppColors.textLight,
                      ),
                    ),
                  ],
                ),
              ),
              if (unlocked)
                const Icon(
                  Icons.check_circle,
                  color: AppColors.primary,
                  size: 20,
                ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
