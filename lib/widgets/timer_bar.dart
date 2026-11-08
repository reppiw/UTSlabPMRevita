import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';

class TimerBar extends StatelessWidget {
  final int secondsLeft;
  final int total;

  const TimerBar({
    super.key,
    required this.secondsLeft,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final fraction = (secondsLeft / total).clamp(0.0, 1.0);
    final barHeight = r.sp(3);

    final Color color;
    if (fraction > 0.5) {
      color = AppColors.accent(3).main;
    } else if (fraction > 0.25) {
      color = AppColors.accent(1).main;
    } else {
      color = Colors.red.shade400;
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Sisa waktu',
              style: TextStyle(
                fontSize: r.sp(3.4),
                color: AppColors.textMuted,
              ),
            ),
            Text(
              '$secondsLeft dtk',
              style: TextStyle(
                fontSize: r.sp(4),
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),
        SizedBox(height: r.sp(1.5)),
        Container(
          height: barHeight,
          decoration: BoxDecoration(
            color: AppColors.border,
            borderRadius: BorderRadius.circular(barHeight),
          ),
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(end: fraction),
            duration: const Duration(milliseconds: 900),
            curve: Curves.linear,
            builder: (context, value, _) => Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: value,
                child: Container(
                  height: barHeight,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(barHeight),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}