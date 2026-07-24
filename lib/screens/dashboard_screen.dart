import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import '../widgets/santri_path.dart';
import 'daily_challenges_screen.dart';
import 'leaderboard_screen.dart';
import 'quiz_category_screen.dart';
import 'reward_shop_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AppUser?>(
      stream: AuthService().currentUserProfileStream,
      builder: (context, snapshot) {
        // Masih menunggu data dari Firestore
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: AppColors.surfaceMuted,
            body: Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        }

        // Data tidak ditemukan (misal dokumen user belum ada di Firestore)
        final user = snapshot.data;
        if (user == null) {
          return const Scaffold(
            backgroundColor: AppColors.surfaceMuted,
            body: Center(
              child: Text('Data pengguna tidak ditemukan.'),
            ),
          );
        }

        return Scaffold(
          backgroundColor: AppColors.surfaceMuted,
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                _Header(name: user.fullName, points: user.points),
                const SizedBox(height: AppSpacing.lg),
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text('Perjalanan Menuju Monaqosah',
                                style: AppText.h2),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.primaryLight,
                              borderRadius:
                                  BorderRadius.circular(AppRadii.pill),
                            ),
                            child: Text('Level ${user.level}',
                                style: AppText.caption
                                    .copyWith(color: AppColors.primaryDark)),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      SantriPath(
                        currentLevel: user.level,
                        totalLevels: 10,
                        progressIntoLevel: user.levelProgress,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  children: [
                    Expanded(
                      child: _StatTile(
                        label: 'Bintang',
                        value: '${user.stars}',
                        icon: Icons.star_rounded,
                        color: AppColors.gold,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: _StatTile(
                        label: 'Poin',
                        value: '${user.points}',
                        icon: Icons.bolt_rounded,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),
                Text('Menu Utama', style: AppText.h2),
                const SizedBox(height: AppSpacing.md),
                _MenuTile(
                  title: 'Mulai Tes',
                  subtitle: 'Uji kemampuan Fiqih, Doa, Tajweed & Gharib',
                  icon: Icons.edit_note_rounded,
                  color: AppColors.primary,
                  bg: AppColors.primaryLight,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_) => const QuizCategoryScreen()),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                _MenuTile(
                  title: 'Tantangan Harian',
                  subtitle: 'Selesaikan misi harian untuk poin ekstra',
                  icon: Icons.flag_rounded,
                  color: AppColors.accent,
                  bg: AppColors.accentLight.withValues(alpha: 0.35),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_) => const DailyChallengesScreen()),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                _MenuTile(
                  title: 'Tukar Hadiah',
                  subtitle: 'Tukar poin kamu dengan hadiah menarik',
                  icon: Icons.card_giftcard_rounded,
                  color: AppColors.gold,
                  bg: AppColors.goldLight,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const RewardShopScreen()),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                _MenuTile(
                  title: 'Papan Peringkat',
                  subtitle: 'Lihat posisimu di antara teman-teman',
                  icon: Icons.leaderboard_rounded,
                  color: AppColors.success,
                  bg: AppColors.successLight,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const LeaderboardScreen()),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  final String name;
  final int points;
  const _Header({required this.name, required this.points});

  void _handleLogout(BuildContext context) {
    // Tampilkan notifikasi ringan bahwa logout berhasil
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Anda sudah logout'),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.sm),
        ),
        duration: const Duration(seconds: 2),
      ),
    );

    // Beri jeda sedikit agar SnackBar sempat tampil
    // sebelum layar berpindah karena stream user berubah menjadi null.
    Future.delayed(const Duration(milliseconds: 300), () {
      AuthService().signOut();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: AppColors.heroGradient),
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.center,
          child: Text(
            name.isNotEmpty ? name.substring(0, 1) : '?',
            style: AppText.h1.copyWith(color: Colors.white),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Semangat Belajar,', style: AppText.bodySoft),
              Text(
                '${name.isNotEmpty ? name.split(' ').first : 'Pengguna'}!',
                style: AppText.h1,
              ),
            ],
          ),
        ),
        PointsPill(points: points),
        const SizedBox(width: 4),
        IconButton(
          icon: const Icon(Icons.logout_rounded, color: AppColors.inkSoft, size: 20),
          onPressed: () => _handleLogout(context),
          tooltip: 'Keluar',
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppRadii.sm),
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: AppSpacing.sm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: AppText.h2),
              Text(label, style: AppText.caption),
            ],
          ),
        ],
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Color bg;
  final VoidCallback onTap;

  const _MenuTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.bg,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadii.lg),
        onTap: onTap,
        child: AppCard(
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(AppRadii.sm),
                ),
                alignment: Alignment.center,
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppText.h2),
                    const SizedBox(height: 2),
                    Text(subtitle, style: AppText.bodySoft),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded,
                  color: AppColors.inkSoft),
            ],
          ),
        ),
      ),
    );
  }
}