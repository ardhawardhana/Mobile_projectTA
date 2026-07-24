import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/reward_model.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sorted = [...MockData.leaderboard]
      ..sort((a, b) => b.points.compareTo(a.points));
    final top3 = sorted.take(3).toList();
    final rest = sorted.skip(3).toList();

    return Scaffold(
      backgroundColor: AppColors.surfaceMuted,
      appBar: AppBar(title: const Text('Papan Peringkat')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            if (top3.length == 3) _Podium(entries: top3),
            const SizedBox(height: AppSpacing.lg),
            ...List.generate(rest.length, (i) {
              final entry = rest[i];
              final rank = i + 4;
              final isMe = entry.userId == MockData.currentStudent.uid;
              return Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: _RankRow(rank: rank, entry: entry, highlighted: isMe),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _Podium extends StatelessWidget {
  final List<LeaderboardEntry> entries; // [0]=1st, [1]=2nd, [2]=3rd
  const _Podium({required this.entries});

  @override
  Widget build(BuildContext context) {
    final order = [entries[1], entries[0], entries[2]]; // 2nd,1st,3rd layout
    final heights = [104.0, 132.0, 88.0];
    final medalColors = [
      const Color(0xFFC0C0C0),
      AppColors.gold,
      const Color(0xFFCD7F32),
    ];
    final rankLabels = ['2', '1', '3'];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(3, (i) {
        final e = order[i];
        return Expanded(
          child: Column(
            children: [
              CircleAvatar(
                radius: i == 1 ? 28 : 24,
                backgroundColor: medalColors[i].withValues(alpha: 0.2),
                child: Text(e.fullName.substring(0, 1),
                    style: AppText.h2.copyWith(color: medalColors[i])),
              ),
              const SizedBox(height: 6),
              Text(
                e.fullName.split(' ').first,
                style: AppText.caption.copyWith(color: AppColors.ink),
                overflow: TextOverflow.ellipsis,
              ),
              Text('${e.points} pts', style: AppText.caption),
              const SizedBox(height: 8),
              Container(
                height: heights[i],
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: medalColors[i],
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(AppRadii.sm)),
                ),
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  rankLabels[i],
                  style: AppText.h1.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _RankRow extends StatelessWidget {
  final int rank;
  final LeaderboardEntry entry;
  final bool highlighted;

  const _RankRow({
    required this.rank,
    required this.entry,
    required this.highlighted,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      color: highlighted ? AppColors.primaryLight : AppColors.surface,
      child: Row(
        children: [
          SizedBox(
            width: 28,
            child: Text('$rank',
                style: AppText.numeric.copyWith(color: AppColors.inkSoft)),
          ),
          const SizedBox(width: AppSpacing.sm),
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.primaryLight,
            child: Text(entry.fullName.substring(0, 1),
                style: AppText.h2.copyWith(color: AppColors.primary)),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entry.fullName, style: AppText.body),
                Text('Level ${entry.level}', style: AppText.caption),
              ],
            ),
          ),
          Text('${entry.points} pts', style: AppText.numeric),
        ],
      ),
    );
  }
}
