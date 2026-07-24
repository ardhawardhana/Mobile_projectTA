import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/reward_model.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import '../widgets/lencana_badge.dart';

class RewardShopScreen extends StatelessWidget {
  const RewardShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = MockData.currentStudent;

    return Scaffold(
      backgroundColor: AppColors.surfaceMuted,
      appBar: AppBar(title: const Text('Tukar Hadiah')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            AppCard(
              color: AppColors.goldLight,
              child: Row(
                children: [
                  const Icon(Icons.bolt_rounded, color: AppColors.gold, size: 28),
                  const SizedBox(width: AppSpacing.sm),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Poin Kamu', style: AppText.caption),
                      Text('${user.points}', style: AppText.h1),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('Lencana yang Diraih', style: AppText.h2),
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              height: 108,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.md),
                itemBuilder: (context, i) {
                  const labels = ['Rajin Sholat', 'Juara Tajweed', 'Hafal Doa', 'Konsisten'];
                  const emojis = ['🕌', '📖', '🤲', '🔥'];
                  return LencanaBadge(
                    emoji: emojis[i],
                    label: labels[i],
                    locked: i >= 2,
                  );
                },
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text('Hadiah Tersedia', style: AppText.h2),
            const SizedBox(height: AppSpacing.md),
            ...MockData.rewards.map((r) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: _RewardTile(reward: r, userPoints: user.points),
                )),
          ],
        ),
      ),
    );
  }
}

class _RewardTile extends StatelessWidget {
  final Reward reward;
  final int userPoints;

  const _RewardTile({required this.reward, required this.userPoints});

  @override
  Widget build(BuildContext context) {
    final canRedeem = userPoints >= reward.pointsRequired;

    return AppCard(
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.surfaceMuted,
              borderRadius: BorderRadius.circular(AppRadii.sm),
            ),
            alignment: Alignment.center,
            child: Text(reward.iconEmoji, style: const TextStyle(fontSize: 26)),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(reward.name, style: AppText.body.copyWith(fontWeight: FontWeight.w700)),
                Text(reward.description, style: AppText.caption),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          SizedBox(
            width: 92,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    canRedeem ? AppColors.primary : AppColors.border,
                foregroundColor:
                    canRedeem ? Colors.white : AppColors.inkSoft,
                padding: const EdgeInsets.symmetric(vertical: 10),
                textStyle: AppText.caption.copyWith(
                  color: canRedeem ? Colors.white : AppColors.inkSoft,
                ),
              ),
              onPressed: canRedeem ? () {} : null,
              child: Text('${reward.pointsRequired} pts'),
            ),
          ),
        ],
      ),
    );
  }
}
