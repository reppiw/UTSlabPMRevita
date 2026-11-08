import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';
import '../widgets/primary_button.dart';
import '../widgets/stat_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final quiz = context.watch<QuizProvider>();
    final history = quiz.history;

    final name = quiz.userName.isEmpty ? 'Pengguna' : quiz.userName;
    final initial = name.substring(0, 1).toUpperCase();

    final total = history.length;
    final average = total == 0
        ? 0
        : (history.map((e) => e.percent).reduce((a, b) => a + b) / total)
            .round();
    final best = total == 0
        ? 0
        : history.map((e) => e.percent).reduce((a, b) => a > b ? a : b);

    final avatarSize = r.sp(26);

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
            'Nama diisi saat memulai kuis',
            style: TextStyle(
              fontSize: r.sp(3.4),
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
        ],
      ),
    );
  }
}