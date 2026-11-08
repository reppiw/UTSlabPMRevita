import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';
import 'chunky_container.dart';

class OptionTile extends StatelessWidget {
  final String label; // huruf opsi: A, B, C, D
  final String text;
  final bool isSelected;
  final int accentIndex;
  final VoidCallback onTap;

  const OptionTile({
    super.key,
    required this.label,
    required this.text,
    required this.isSelected,
    required this.onTap,
    this.accentIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final accent = AppColors.accent(accentIndex);

    // Belum dipilih: garis tepi warna aksen yang dilembutkan.
    final softEdge = Color.lerp(AppColors.border, accent.main, 0.55)!;
    final edge = isSelected ? accent.main : softEdge;

    return Padding(
      padding: EdgeInsets.only(bottom: r.sp(2.2)),
      child: ChunkyContainer(
        onTap: onTap,
        color: isSelected ? accent.soft : AppColors.surface,
        shadowColor: isSelected ? accent.shadow : softEdge,
        borderColor: edge,
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
            Container(
              width: r.sp(8.5),
              height: r.sp(8.5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: accent.main,
                borderRadius: BorderRadius.circular(r.sp(2.5)),
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: r.sp(3.8),
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
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
                  color: isSelected ? accent.text : AppColors.textDark,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}