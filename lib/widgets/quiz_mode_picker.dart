import 'package:flutter/material.dart';
import '../models/quiz_mode.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';
import 'chunky_container.dart';

class QuizModePicker extends StatelessWidget {
  final QuizMode selected;
  final ValueChanged<QuizMode> onChanged;

  const QuizModePicker({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  Widget _option(Responsive r, QuizMode mode, int accentIndex) {
    final accent = AppColors.accent(accentIndex);
    final isSelected = selected == mode;

    return ChunkyContainer(
      onTap: () => onChanged(mode),
      color: isSelected ? accent.main : AppColors.surface,
      shadowColor: isSelected ? accent.shadow : AppColors.border,
      borderColor: isSelected ? accent.shadow : AppColors.border,
      borderWidth: r.sp(0.5),
      depth: r.sp(1),
      radius: r.sp(4),
      padding: EdgeInsets.symmetric(vertical: r.sp(3.2)),
      child: Text(
        mode.label.toUpperCase(),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: r.sp(3.6),
          fontWeight: FontWeight.w700,
          letterSpacing: r.sp(0.15),
          color: isSelected ? Colors.white : AppColors.textDark,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(child: _option(r, QuizMode.casual, 3)),
            SizedBox(width: r.w(3)),
            Expanded(child: _option(r, QuizMode.timed, 1)),
          ],
        ),
        SizedBox(height: r.h(1.2)),
        Text(
          selected.description,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: r.sp(3.4),
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }
}