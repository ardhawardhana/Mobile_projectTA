import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/question_model.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import 'quiz_screen.dart';

class QuizCategoryScreen extends StatelessWidget {
  const QuizCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceMuted,
      appBar: AppBar(title: const Text('Mulai Tes')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            Text('Pilih kategori yang ingin\nkamu pelajari hari ini.',
                style: AppText.bodySoft),
            const SizedBox(height: AppSpacing.lg),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: AppSpacing.md,
              crossAxisSpacing: AppSpacing.md,
              childAspectRatio: 0.82,
              children: MockData.categories
                  .map((c) => _CategoryCard(category: c))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final QuizCategory category;
  const _CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadii.lg),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => QuizScreen(category: category),
            ),
          );
        },
        child: AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(AppRadii.sm),
                ),
                alignment: Alignment.center,
                child: Text(category.iconEmoji,
                    style: const TextStyle(fontSize: 22)),
              ),
              const Spacer(),
              Text(
                category.name,
                style: AppText.h2,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                category.description,
                style: AppText.caption,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
