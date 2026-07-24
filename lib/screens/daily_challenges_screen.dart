import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/challenge_model.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class DailyChallengesScreen extends StatefulWidget {
  const DailyChallengesScreen({super.key});

  @override
  State<DailyChallengesScreen> createState() => _DailyChallengesScreenState();
}

class _DailyChallengesScreenState extends State<DailyChallengesScreen> {
  @override
  Widget build(BuildContext context) {
    final challenges = MockData.dailyChallenges;

    return Scaffold(
      backgroundColor: AppColors.surfaceMuted,
      appBar: AppBar(
        title: const Text('Tantangan Harian'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            // Streak Section
            AppCard(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('🔥', style: TextStyle(fontSize: 32)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Streak 5 Hari!',
                              style: AppText.h1.copyWith(color: AppColors.gold),
                            ),
                            Text(
                              'Selesaikan tantangan setiap hari untuk menjaga streak',
                              style: AppText.caption,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _buildWeeklyStreak(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('Misi Hari Ini', style: AppText.h2),
            const SizedBox(height: AppSpacing.md),
            // Challenges List
            ...challenges.map((c) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: _ChallengeTile(
                    challenge: c,
                    onClaim: () {
                      setState(() {
                        MockData.claimChallenge(c.id);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Selamat! Kamu mendapatkan +${c.pointsReward} poin! 🎉'),
                          backgroundColor: AppColors.success,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildWeeklyStreak() {
    const days = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Ahd'];
    const streak = [true, true, true, true, true, false, false]; // 5-day streak representation

    return List.generate(7, (i) {
      final isDone = streak[i];
      return Column(
        children: [
          Text(days[i], style: AppText.caption),
          const SizedBox(height: 6),
          CircleAvatar(
            radius: 16,
            backgroundColor: isDone ? AppColors.gold : AppColors.border,
            child: isDone
                ? const Icon(Icons.check_rounded, color: Colors.white, size: 16)
                : const Icon(Icons.circle, color: Colors.white, size: 8),
          ),
        ],
      );
    });
  }
}

class _ChallengeTile extends StatelessWidget {
  final DailyChallenge challenge;
  final VoidCallback onClaim;

  const _ChallengeTile({
    required this.challenge,
    required this.onClaim,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: challenge.isClaimed
                      ? AppColors.border.withValues(alpha: 0.3)
                      : AppColors.primaryLight,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  challenge.iconEmoji,
                  style: const TextStyle(fontSize: 22),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      challenge.title,
                      style: AppText.body.copyWith(
                        fontWeight: FontWeight.bold,
                        decoration: challenge.isClaimed ? TextDecoration.lineThrough : null,
                        color: challenge.isClaimed ? AppColors.inkSoft : AppColors.ink,
                      ),
                    ),
                    Text(
                      challenge.description,
                      style: AppText.caption,
                    ),
                  ],
                ),
              ),
              PointsPill(points: challenge.pointsReward),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadii.pill),
                  child: LinearProgressIndicator(
                    value: challenge.progress,
                    minHeight: 6,
                    backgroundColor: AppColors.surfaceMuted,
                    valueColor: AlwaysStoppedAnimation(
                      challenge.isCompleted ? AppColors.success : AppColors.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              _buildActionButton(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    if (challenge.isClaimed) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.successLight,
          borderRadius: BorderRadius.circular(AppRadii.pill),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 14),
            const SizedBox(width: 4),
            Text(
              'Selesai',
              style: AppText.caption.copyWith(color: AppColors.success, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    }

    if (challenge.isCompleted) {
      return SizedBox(
        height: 32,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.gold,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadii.sm),
            ),
          ),
          onPressed: onClaim,
          child: Text('Klaim', style: AppText.caption.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.border.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppRadii.pill),
      ),
      child: Text(
        'Belum Selesai',
        style: AppText.caption.copyWith(color: AppColors.inkSoft),
      ),
    );
  }
}
