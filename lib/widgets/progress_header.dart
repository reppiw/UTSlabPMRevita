import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';

class ProgressHeader extends StatelessWidget {
  final String userName;
  final int current; // nomor soal, mulai dari 1
  final int total;
  final double progress; // tidak dipakai, dipertahankan agar kompatibel

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
    final barHeight = r.sp(3.2);
    final gap = r.sp(1);

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
        Row(
          children: [
            for (int i = 0; i < total; i++)
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: i == total - 1 ? 0 : gap),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: barHeight,
                    decoration: BoxDecoration(
                      color: i < current
                          ? AppColors.accent(i).main
                          : AppColors.border,
                      borderRadius: BorderRadius.circular(barHeight),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}