import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';
import 'chunky_container.dart';

class ThemeSwatch extends StatelessWidget {
  final AppPalette palette;
  final bool isSelected;
  final VoidCallback onTap;

  const ThemeSwatch({
    super.key,
    required this.palette,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final edge = isSelected ? palette.primary : AppColors.border;
    final dot = r.sp(5);

    return ChunkyContainer(
      onTap: onTap,
      color: isSelected
          ? Color.lerp(AppColors.surface, palette.primary, 0.14)!
          : AppColors.surface,
      shadowColor: edge,
      borderColor: edge,
      borderWidth: r.sp(0.5),
      depth: r.sp(1),
      radius: r.sp(4),
      padding: EdgeInsets.symmetric(vertical: r.sp(3), horizontal: r.sp(2)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (final accent in palette.accents)
                Container(
                  width: dot,
                  height: dot,
                  margin: EdgeInsets.symmetric(horizontal: r.sp(0.5)),
                  decoration: BoxDecoration(
                    color: accent.main,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
          SizedBox(height: r.sp(2)),
          Text(
            palette.name,
            style: TextStyle(
              fontSize: r.sp(3.8),
              fontWeight: FontWeight.w700,
              color: isSelected ? palette.primary : AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }
}