import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// A scalloped rosette-shaped badge for earned "lencana" (badges/medals),
/// a small nod to the ornamental medal shapes used in achievement
/// certificates rather than a plain circle or square chip.
class LencanaBadge extends StatelessWidget {
  final String emoji;
  final String label;
  final bool locked;
  final double size;

  const LencanaBadge({
    super.key,
    required this.emoji,
    required this.label,
    this.locked = false,
    this.size = 76,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: size,
          height: size,
          child: CustomPaint(
            painter: _RosettePainter(locked: locked),
            child: Center(
              child: Opacity(
                opacity: locked ? 0.35 : 1,
                child: Text(emoji, style: TextStyle(fontSize: size * 0.34)),
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: size + 12,
          child: Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppText.caption.copyWith(
              color: locked ? AppColors.inkSoft : AppColors.ink,
            ),
          ),
        ),
      ],
    );
  }
}

class _RosettePainter extends CustomPainter {
  final bool locked;
  _RosettePainter({required this.locked});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final outerR = size.width / 2;
    final innerR = outerR * 0.82;
    const points = 12;

    final path = Path();
    for (int i = 0; i < points * 2; i++) {
      final isOuter = i.isEven;
      final r = isOuter ? outerR : innerR;
      final angle = (math.pi / points) * i - math.pi / 2;
      final p = Offset(
        center.dx + r * math.cos(angle),
        center.dy + r * math.sin(angle),
      );
      if (i == 0) {
        path.moveTo(p.dx, p.dy);
      } else {
        path.lineTo(p.dx, p.dy);
      }
    }
    path.close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        colors: locked
            ? [AppColors.border, AppColors.border]
            : AppColors.goldGradient,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromCircle(center: center, radius: outerR));

    canvas.drawPath(path, fillPaint);
    canvas.drawCircle(center, innerR * 0.72, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant _RosettePainter oldDelegate) =>
      oldDelegate.locked != locked;
}
