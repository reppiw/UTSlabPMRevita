import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';
import 'chunky_container.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool outlined;
  final int? accentIndex; // 0-4, kosong = warna utama tema

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.outlined = false,
    this.accentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final enabled = onPressed != null;

    final accent =
        accentIndex == null ? null : AppColors.accent(accentIndex!);
    final main = accent?.main ?? AppColors.primary;
    final shadow = accent?.shadow ?? AppColors.primaryShadow;
    final text = accent?.text ?? AppColors.primaryText;

    late final Color face;
    late final Color shadowColor;
    late final Color textColor;
    Color? border;

    if (!enabled) {
      face = AppColors.disabled;
      shadowColor = AppColors.border;
      textColor = AppColors.disabledText;
    } else if (outlined) {
      face = AppColors.surface;
      shadowColor = main;
      border = main;
      textColor = text;
    } else {
      face = main;
      shadowColor = shadow;
      textColor = Colors.white;
    }

    return ChunkyContainer(
      onTap: onPressed,
      color: face,
      shadowColor: shadowColor,
      borderColor: border,
      borderWidth: r.sp(0.5),
      depth: r.sp(1.2),
      radius: r.sp(4),
      padding: EdgeInsets.symmetric(
        horizontal: r.w(4),
        vertical: r.sp(3.6),
      ),
      child: Text(
        label.toUpperCase(),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: r.sp(3.8),
          fontWeight: FontWeight.w700,
          letterSpacing: r.sp(0.2),
          color: textColor,
        ),
      ),
    );
  }
}