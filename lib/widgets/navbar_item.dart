import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';

class NavbarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const NavbarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final radius = BorderRadius.circular(r.sp(3.5));

    return Semantics(
      label: label,
      button: true,
      selected: isActive,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: r.sp(12),
          width: r.sp(17),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? AppColors.selectedFill : Colors.transparent,
            borderRadius: radius,
            border: Border.all(
              color: isActive ? AppColors.primary : Colors.transparent,
              width: r.sp(0.5),
            ),
          ),
          child: Icon(
            icon,
            size: r.sp(7.5),
            color: isActive ? AppColors.primary : AppColors.textMuted,
          ),
        ),
      ),
    );
  }
}