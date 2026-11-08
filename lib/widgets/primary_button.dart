import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';
import 'chunky_container.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool outlined;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final enabled = onPressed != null;

    late final Color face;
    late final Color shadow;
    late final Color textColor;
    Color? border;

    if (!enabled) {
      face = AppColors.disabled;
      shadow = AppColors.border;
      textColor = AppColors.disabledText;
    } else if (outlined) {
      face = AppColors.surface;
      shadow = AppColors.border;
      border = AppColors.border;
      textColor = AppColors.primaryShadow;
    } else {
      face = AppColors.primary;
      shadow = AppColors.primaryShadow;
      textColor = AppColors.onPrimary;
    }

    return ChunkyContainer(
      onTap: onPressed,
      color: face,
      shadowColor: shadow,
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