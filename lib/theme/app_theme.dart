import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// ---------------------------------------------------------------------
/// DESIGN TOKENS
/// Subject: Monaqosah exam-prep for santri (children, ~7-12) at TPQ
/// Darul Ishlah. The palette follows the brief (soft blue / soft rose)
/// with two additions justified by the gamification mechanics:
///   - `gold`   : stars, points, coins — a "treasure" color distinct
///                from the primary/accent so rewards always read as
///                rewards, never as a navigation or brand color.
///   - `success`: correct-answer state in the quiz, kept separate from
///                gold so "earned currency" and "correct answer" don't
///                visually collide.
/// Type pairing: Baloo 2 (rounded, warm, great at large display sizes —
/// the greeting, the score circle) + Plus Jakarta Sans (clean, calm,
/// legible at small sizes for tables/leaderboards/body copy). Avoids the
/// generic "Inter everywhere" default.
/// ---------------------------------------------------------------------
class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF0284C7); // sky-600
  static const Color primaryLight = Color(0xFFE0F2FE); // sky-100
  static const Color primaryDark = Color(0xFF075985); // sky-800

  static const Color accent = Color(0xFFF43F5E); // rose-500
  static const Color accentLight = Color(0xFFFDA4AF); // rose-300

  static const Color gold = Color(0xFFF59E0B); // amber-500 — stars/points
  static const Color goldLight = Color(0xFFFEF3C7); // amber-100

  static const Color success = Color(0xFF16A34A); // green-600 — correct
  static const Color successLight = Color(0xFFDCFCE7);
  static const Color danger = Color(0xFFEF4444); // wrong answer
  static const Color dangerLight = Color(0xFFFEE2E2);

  static const Color ink = Color(0xFF1E293B); // slate-800 text
  static const Color inkSoft = Color(0xFF64748B); // slate-500 secondary text
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceMuted = Color(0xFFF3F4F6);
  static const Color border = Color(0xFFE2E8F0);

  static const List<Color> heroGradient = [primary, Color(0xFF0EA5E9)];
  static const List<Color> goldGradient = [Color(0xFFFBBF24), gold];
}

class AppRadii {
  AppRadii._();
  static const double sm = 12;
  static const double md = 18;
  static const double lg = 24;
  static const double pill = 999;
}

class AppSpacing {
  AppSpacing._();
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
}

class AppText {
  AppText._();

  static TextStyle display = GoogleFonts.baloo2(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    color: AppColors.ink,
    height: 1.15,
  );

  static TextStyle h1 = GoogleFonts.baloo2(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.ink,
  );

  static TextStyle h2 = GoogleFonts.baloo2(
    fontSize: 19,
    fontWeight: FontWeight.w600,
    color: AppColors.ink,
  );

  static TextStyle body = GoogleFonts.plusJakartaSans(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.ink,
    height: 1.4,
  );

  static TextStyle bodySoft = GoogleFonts.plusJakartaSans(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.inkSoft,
    height: 1.4,
  );

  static TextStyle caption = GoogleFonts.plusJakartaSans(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.inkSoft,
    letterSpacing: 0.2,
  );

  static TextStyle numeric = GoogleFonts.plusJakartaSans(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.ink,
  );

  static TextStyle button = GoogleFonts.plusJakartaSans(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.1,
  );
}

class AppTheme {
  AppTheme._();

  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.surfaceMuted,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: AppColors.surface,
      ),
      textTheme: TextTheme(
        displayLarge: AppText.display,
        headlineMedium: AppText.h1,
        titleMedium: AppText.h2,
        bodyMedium: AppText.body,
        bodySmall: AppText.bodySoft,
        labelLarge: AppText.button,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(color: AppColors.ink),
        titleTextStyle: AppText.h2,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          textStyle: AppText.button,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.md),
          ),
          elevation: 0,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceMuted,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.md),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.md),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.md),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.6),
        ),
        hintStyle: AppText.bodySoft,
      ),
      fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
    );
  }
}
