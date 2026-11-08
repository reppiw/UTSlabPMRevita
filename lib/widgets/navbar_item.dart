import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';

class NavbarItem extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const NavbarItem({
    super.key,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(r.sp(2)),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: r.sp(2.2),
          vertical: r.sp(1.5),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label.toUpperCase(),
              style: TextStyle(
                fontSize: r.sp(3.2),
                fontWeight: FontWeight.w700,
                letterSpacing: r.sp(0.15),
                color: isActive ? AppColors.primary : AppColors.textMuted,
              ),
            ),
            SizedBox(height: r.sp(0.8)),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: r.sp(0.8),
              width: isActive ? r.sp(8) : 0,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(r.sp(1)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}