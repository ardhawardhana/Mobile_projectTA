import 'package:flutter/material.dart';
import '../models/question_model.dart';
import '../models/test_result_model.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import '../widgets/star_rating.dart';
import 'dashboard_screen.dart';
import 'quiz_screen.dart';
import 'reward_shop_screen.dart';

class QuizResultScreen extends StatelessWidget {
  final QuizCategory category;
  final TestResult result;

  const QuizResultScreen({
    super.key,
    required this.category,
    required this.result,
  });

  String get _motivation {
    if (result.starsEarned == 3) return 'Masya Allah, luar biasa! 🎉';
    if (result.starsEarned == 2) return 'Bagus sekali, terus semangat! 💪';
    if (result.starsEarned == 1) return 'Sudah baik, ayo coba lagi! 🌱';
    return 'Jangan menyerah, coba lagi ya! 🤗';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              const Spacer(),
              Text(category.name, style: AppText.h2.copyWith(color: AppColors.inkSoft)),
              const SizedBox(height: AppSpacing.lg),
              _ScoreCircle(score: result.score),
              const SizedBox(height: AppSpacing.lg),
              StarRating(earned: result.starsEarned, size: 36),
              const SizedBox(height: AppSpacing.md),
              Text(_motivation, style: AppText.h1, textAlign: TextAlign.center),
              const SizedBox(height: AppSpacing.sm),
              Text(
                '${result.correctCount} benar • ${result.wrongCount} salah dari ${result.correctCount + result.wrongCount} soal',
                style: AppText.bodySoft,
              ),
              const Spacer(),
              GradientButton(
                label: 'Ambil Hadiah',
                icon: Icons.card_giftcard_rounded,
                colors: AppColors.goldGradient,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const RewardShopScreen()),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: AppColors.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadii.md),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => QuizScreen(category: category),
                      ),
                    );
                  },
                  child: Text('Coba Lagi',
                      style: AppText.button.copyWith(color: AppColors.ink)),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              TextButton(
                onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const DashboardScreen()),
                  (route) => false,
                ),
                child: Text('Kembali ke Beranda',
                    style: AppText.bodySoft.copyWith(color: AppColors.primary)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScoreCircle extends StatelessWidget {
  final int score;
  const _ScoreCircle({required this.score});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 168,
      height: 168,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 168,
            height: 168,
            child: CircularProgressIndicator(
              value: score / 100,
              strokeWidth: 12,
              backgroundColor: AppColors.surfaceMuted,
              valueColor: const AlwaysStoppedAnimation(AppColors.primary),
              strokeCap: StrokeCap.round,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('$score', style: AppText.display.copyWith(fontSize: 44)),
              Text('Skor Kamu', style: AppText.caption),
            ],
          ),
        ],
      ),
    );
  }
}
