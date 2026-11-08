import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';
import 'chunky_container.dart';

class ModeToggle extends StatelessWidget { //utk dark dan light agar gayanya sama dgn tombol lain
  final bool isDark;
  final ValueChanged<bool> onChanged;

  const ModeToggle({
    super.key,
    required this.isDark,
    required this.onChanged,
  });

  Widget _option(Responsive r, String label, bool selected, VoidCallback onTap) {
    return ChunkyContainer(
      onTap: onTap,
      color: selected ? AppColors.primary : AppColors.surface,
      shadowColor: selected ? AppColors.primaryShadow : AppColors.border,
      borderColor: selected ? AppColors.primaryShadow : AppColors.border,
      borderWidth: r.sp(0.5),
      depth: r.sp(1),
      radius: r.sp(4),
      padding: EdgeInsets.symmetric(vertical: r.sp(3.5)),
      child: Text(
        label.toUpperCase(),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: r.sp(3.8),
          fontWeight: FontWeight.w700,
          letterSpacing: r.sp(0.2),
          color: selected ? AppColors.onPrimary : AppColors.textDark,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);

    return Row(
      children: [
        Expanded(
          child: _option(r, 'Terang', !isDark, () => onChanged(false)),
        ),
        SizedBox(width: r.w(3)),
        Expanded(
          child: _option(r, 'Gelap', isDark, () => onChanged(true)),
        ),
      ],
    );
  }
}