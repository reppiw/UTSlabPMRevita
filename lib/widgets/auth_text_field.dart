import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final bool obscureText;
  final Widget? suffix;
  final ValueChanged<String>? onSubmitted;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.none,
    this.obscureText = false,
    this.suffix,
    this.onSubmitted,
  });

  OutlineInputBorder _border(Responsive r, Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(r.sp(4)),
      borderSide: BorderSide(color: color, width: r.sp(0.6)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);

    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      obscureText: obscureText,
      onFieldSubmitted: onSubmitted,
      style: TextStyle(fontSize: r.sp(4.2), color: AppColors.textDark),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        suffix: suffix,
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: EdgeInsets.symmetric(
          horizontal: r.sp(4),
          vertical: r.sp(4),
        ),
        enabledBorder: _border(r, AppColors.border),
        focusedBorder: _border(r, AppColors.primary),
        errorBorder: _border(r, Colors.red.shade400),
        focusedErrorBorder: _border(r, Colors.red.shade400),
      ),
    );
  }
}