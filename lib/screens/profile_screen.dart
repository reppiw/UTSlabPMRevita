import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/quiz_provider.dart';
import '../providers/theme_provider.dart';
import '../utils/app_colors.dart';
import '../utils/page_transition.dart';
import '../utils/responsive.dart';
import '../widgets/mode_toggle.dart';
import '../widgets/primary_button.dart';
import '../widgets/stat_card.dart';
import '../widgets/theme_swatch.dart';
import 'login_screen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void _logout(BuildContext context) {
    context.read<AuthProvider>().logout();
    context.read<QuizProvider>().resetAll();
    Navigator.pushAndRemoveUntil(
      context,
      FadeSlideRoute(page: const LoginScreen()),
      (route) => false,
    );
  }

  Widget _sectionTitle(Responsive r, String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(bottom: r.h(1.5)),
        child: Text(
          text,
          style: TextStyle(
            fontSize: r.sp(5),
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final quiz = context.watch<QuizProvider>();
    final user = context.watch<AuthProvider>().currentUser;
    final themeState = context.watch<ThemeProvider>();
    final history = quiz.history;

    final name = user?.name ?? 'Pengguna';
    final email = user?.email ?? '';
    final initial = name.isEmpty ? '?' : name.substring(0, 1).toUpperCase();

    final total = history.length;
    final average = total == 0
        ? 0
        : (history.map((e) => e.percent).reduce((a, b) => a + b) / total)
            .round();
    final best = total == 0
        ? 0
        : history.map((e) => e.percent).reduce((a, b) => a > b ? a : b);

    final avatarSize = r.sp(26);

    // Lebar kartu tema: 2 per baris (portrait), 3 per baris (landscape).
    final gap = r.w(3);
    final perRow = r.isLandscape ? 3 : 2;
    final swatchWidth = (r.w(88) - gap * (perRow - 1)) / perRow;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: r.w(6), vertical: r.h(3)),
      child: Column(
        children: [
          Container(
            width: avatarSize,
            height: avatarSize,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primaryShadow,
                width: r.sp(1),
              ),
            ),
            child: Text(
              initial,
              style: TextStyle(
                fontSize: r.sp(12),
                fontWeight: FontWeight.w700,
                color: AppColors.onPrimary,
              ),
            ),
          ),
          SizedBox(height: r.h(2)),
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: r.sp(6),
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
          SizedBox(height: r.h(0.5)),
          Text(
            email,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: r.sp(3.6),
              color: AppColors.textMuted,
            ),
          ),
          SizedBox(height: r.h(3)),
          Row(
            children: [
              Expanded(
                child: StatCard(value: '$total', label: 'Kuis dikerjakan'),
              ),
              SizedBox(width: r.w(3)),
              Expanded(
                child: StatCard(value: '$average', label: 'Rata-rata skor'),
              ),
              SizedBox(width: r.w(3)),
              Expanded(
                child: StatCard(value: '$best', label: 'Skor terbaik'),
              ),
            ],
          ),

          SizedBox(height: r.h(4)),
          _sectionTitle(r, 'Mode'),
          ModeToggle(
            isDark: themeState.isDark,
            onChanged: (value) =>
                context.read<ThemeProvider>().setDark(value),
          ),

          SizedBox(height: r.h(3)),
          _sectionTitle(r, 'Tema'),
          Align(
            alignment: Alignment.centerLeft,
            child: Wrap(
              spacing: gap,
              runSpacing: r.h(1.5),
              children: [
                for (int i = 0; i < AppPalette.all.length; i++)
                  SizedBox(
                    width: swatchWidth,
                    child: ThemeSwatch(
                      palette: AppPalette.all[i],
                      isSelected: themeState.themeIndex == i,
                      onTap: () => context.read<ThemeProvider>().setTheme(i),
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: r.h(4)),
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              label: 'Hapus Riwayat',
              outlined: true,
              onPressed: total == 0
                  ? null
                  : () => context.read<QuizProvider>().clearHistory(),
            ),
          ),
          SizedBox(height: r.h(1.5)),
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              label: 'Keluar',
              onPressed: () => _logout(context),
            ),
          ),
        ],
      ),
    );
  }
}