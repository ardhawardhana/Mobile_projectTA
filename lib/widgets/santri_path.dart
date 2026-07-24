import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Signature element for the dashboard: the student's progress toward
/// Monaqosah rendered as a winding dotted path with milestone markers,
/// rather than a flat linear progress bar. Frames the exam prep as a
/// journey ("perjalanan santri") the child is walking step by step,
/// which fits the subject better than a generic percentage bar.
class SantriPath extends StatelessWidget {
  final int currentLevel;
  final int totalLevels;
  final double progressIntoLevel; // 0.0 - 1.0

  const SantriPath({
    super.key,
    required this.currentLevel,
    required this.totalLevels,
    required this.progressIntoLevel,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 92,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return CustomPaint(
            size: Size(constraints.maxWidth, 92),
            painter: _SantriPathPainter(
              currentLevel: currentLevel,
              totalLevels: totalLevels,
              progressIntoLevel: progressIntoLevel,
            ),
          );
        },
      ),
    );
  }
}

class _SantriPathPainter extends CustomPainter {
  final int currentLevel;
  final int totalLevels;
  final double progressIntoLevel;

  _SantriPathPainter({
    required this.currentLevel,
    required this.totalLevels,
    required this.progressIntoLevel,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final trackPaint = Paint()
      ..color = AppColors.border
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final donePaint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final midY = size.height / 2;
    final path = Path()..moveTo(0, midY);
    path.lineTo(size.width, midY);

    // Dashed track (drawn as short segments for a "dotted path" feel).
    const dashWidth = 8.0;
    const dashGap = 6.0;
    double x = 0;
    while (x < size.width) {
      canvas.drawLine(
          Offset(x, midY), Offset(x + dashWidth, midY), trackPaint);
      x += dashWidth + dashGap;
    }

    final milestoneCount = totalLevels;
    final overallProgress =
        ((currentLevel - 1) + progressIntoLevel) / (milestoneCount - 1);
    final doneWidth = (size.width * overallProgress).clamp(0, size.width);

    x = 0;
    while (x < doneWidth) {
      final end = (x + dashWidth).clamp(0, doneWidth);
      canvas.drawLine(
          Offset(x, midY), Offset(end.toDouble(), midY), donePaint);
      x += dashWidth + dashGap;
    }

    // Milestone markers.
    for (int i = 0; i < milestoneCount; i++) {
      final cx = size.width * (i / (milestoneCount - 1));
      final isDone = i < currentLevel - 1;
      final isCurrent = i == currentLevel - 1;
      final center = Offset(cx, midY);

      final fillColor = isDone ? AppColors.primary : Colors.white;
      final markerPaint = Paint()
        ..color = fillColor
        ..style = PaintingStyle.fill;
      final ringPaint = Paint()
        ..color = isDone || isCurrent ? AppColors.primary : AppColors.border
        ..strokeWidth = 2.5
        ..style = PaintingStyle.stroke;

      final radius = isCurrent ? 14.0 : 10.0;
      canvas.drawCircle(center, radius, markerPaint);
      canvas.drawCircle(center, radius, ringPaint);

      if (isDone) {
        _drawCheck(canvas, center, radius);
      } else if (isCurrent) {
        canvas.drawCircle(center, 5, Paint()..color = AppColors.gold);
      }

      // Level label under each milestone.
      final tp = TextPainter(
        text: TextSpan(
          text: '${i + 1}',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: isDone || isCurrent ? AppColors.primary : AppColors.inkSoft,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(cx - tp.width / 2, midY + 20));
    }
  }

  void _drawCheck(Canvas canvas, Offset center, double radius) {
    final checkPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final p = Path()
      ..moveTo(center.dx - 4, center.dy)
      ..lineTo(center.dx - 1, center.dy + 3)
      ..lineTo(center.dx + 4, center.dy - 4);
    canvas.drawPath(p, checkPaint);
  }

  @override
  bool shouldRepaint(covariant _SantriPathPainter oldDelegate) {
    return oldDelegate.currentLevel != currentLevel ||
        oldDelegate.progressIntoLevel != progressIntoLevel;
  }
}
