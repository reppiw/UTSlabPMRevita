import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';
import '../widgets/history_tile.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final history = context.watch<QuizProvider>().history;

    if (history.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: r.w(10)),
          child: Text(
            'Belum ada kuis yang dikerjakan.\nMulai dari Beranda!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: r.sp(4.2),
              color: AppColors.textMuted,
            ),
          ),
        ),
      );
    }

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: r.w(5), vertical: r.h(2)),
      children: [
        for (final entry in history) HistoryTile(entry: entry),
      ],
    );
  }
}