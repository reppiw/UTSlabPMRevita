import 'package:flutter/material.dart';
import '../utils/responsive.dart';

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
    final color = Theme.of(context).colorScheme.primary;

    final content = Text(
      label,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: r.sp(4),
        fontWeight: FontWeight.w500,
      ),
    );

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(r.sp(3)),
    );
    final padding = EdgeInsets.symmetric(
      horizontal: r.w(6),
      vertical: r.sp(3.5),
    );

    return outlined
    ? OutlinedButton(
      onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: color,
          side: BorderSide(color: color, width: r.sp(0.4)),
          shape: shape,
          padding: padding,
        ),
        child: content,
      )

    : ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          disabledBackgroundColor: Colors.grey.shade300,
          shape: shape,
          padding: padding,
        ),
        child: content,
      );
  }
}