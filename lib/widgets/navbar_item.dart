import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';

class NavbarItem extends StatelessWidget {
  final IconData icon;
  final String label; // hanya untuk aksesibilitas, tidak ditampilkan
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

    return Semantics(
      label: label,
      button: true,
      selected: isActive,
      child: InkResponse(
        onTap: onTap,
        radius: r.sp(8),
        child: SizedBox(
          height: r.sp(12),
          width: r.sp(17),
          child: Center(
            child: AnimatedScale(
              scale: isActive ? 1.2 : 1.0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              child: Icon(
                icon,
                size: r.sp(7.5),
                color: isActive
                    ? AppColors.onPrimary
                    : const Color.fromRGBO(255, 255, 255, 0.6),
              ),
            ),
          ),
        ),
      ),
    );
  }
}