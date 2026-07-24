import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Renders `earned` filled stars out of `total`, used on the quiz result
/// screen and anywhere a per-attempt star rating is shown.
class StarRating extends StatelessWidget {
  final int earned;
  final int total;
  final double size;

  const StarRating({
    super.key,
    required this.earned,
    this.total = 3,
    this.size = 28,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(total, (i) {
        final filled = i < earned;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: Icon(
            filled ? Icons.star_rounded : Icons.star_outline_rounded,
            size: size,
            color: filled ? AppColors.gold : AppColors.border,
          ),
        );
      }),
    );
  }
}
