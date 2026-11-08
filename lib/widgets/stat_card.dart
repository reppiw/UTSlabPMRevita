import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';

class StatCard extends StatelessWidget {
  final String value;
  final String label;

  const StatCard({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: r.sp(4),
        horizontal: r.sp(2),
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(r.sp(4)),
        border: Border.all(color: AppColors.border, width: r.sp(0.5)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: r.sp(6.5),
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: r.sp(1)),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: r.sp(3),
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}