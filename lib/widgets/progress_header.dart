import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';

class ProgressHeader extends StatelessWidget {
  final String userName;
  final int current; // nomor soal, mulai dari 1
  final int total;
  final double progress; // 0.0 - 1.0

  const ProgressHeader({
    super.key,
    required this.userName,
    required this.current,
    required this.total,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final barHeight = r.sp(4);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                userName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: r.sp(4.2),
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
            ),
            Text(
              'Soal $current/$total',
              style: TextStyle(
                fontSize: r.sp(3.6),
                fontWeight: FontWeight.w500,
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
        SizedBox(height: r.sp(2.5)),
        Container(
          height: barHeight,
          decoration: BoxDecoration(
            color: AppColors.border,
            borderRadius: BorderRadius.circular(barHeight),
          ),
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: progress),
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
            builder: (context, value, _) => Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: value.clamp(0.0, 1.0),
                child: Container(
                  height: barHeight,
                  padding: EdgeInsets.symmetric(
                    horizontal: barHeight * 0.4,
                    vertical: barHeight * 0.2,
                  ),
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(barHeight),
                  ),
                  // Kilau tipis di bagian atas bar
                  child: Container(
                    height: barHeight * 0.22,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 255, 255, 0.3),
                      borderRadius: BorderRadius.circular(barHeight),
                    ),
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