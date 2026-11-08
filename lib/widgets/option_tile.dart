import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';
import 'chunky_container.dart';

class OptionTile extends StatelessWidget {
  final String label; // huruf opsi: A, B, C, D
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const OptionTile({
    super.key,
    required this.label,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final accent = isSelected ? AppColors.primary : AppColors.border;

    return Padding(
      padding: EdgeInsets.only(bottom: r.sp(2.2)),
      child: ChunkyContainer(
        onTap: onTap,
        color: isSelected ? AppColors.selectedFill : AppColors.surface,
        shadowColor: accent,
        borderColor: accent,
        borderWidth: r.sp(0.5),
        depth: r.sp(1),
        radius: r.sp(4),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(
          horizontal: r.sp(3.5),
          vertical: r.sp(3),
        ),
        child: Row(
          children: [
            // Kotak huruf opsi
            Container(
              width: r.sp(8.5),
              height: r.sp(8.5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.surface,
                borderRadius: BorderRadius.circular(r.sp(2.5)),
                border: Border.all(color: accent, width: r.sp(0.5)),
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: r.sp(3.8),
                  fontWeight: FontWeight.w700,
                  color: isSelected
                      ? AppColors.onPrimary
                      : AppColors.textMuted,
                ),
              ),
            ),
            SizedBox(width: r.sp(3.5)),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: r.sp(4),
                  fontWeight: FontWeight.w500,
                  color: isSelected
                      ? AppColors.primaryShadow
                      : AppColors.textDark,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}