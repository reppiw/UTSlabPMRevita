import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';

class BookmarkLabel extends StatelessWidget {
  final String text;
  final int accentIndex; // warna kotak (0-4)

  const BookmarkLabel({
    super.key,
    required this.text,
    this.accentIndex = 2,
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final accent = AppColors.accent(accentIndex);

    return SizedBox(
      width: double.infinity,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.only(
            left: r.w(5),
            right: r.w(6),
            top: r.sp(2.5),
            bottom: r.sp(2.5),
          ),
          decoration: BoxDecoration(
            color: accent.main,
            borderRadius: BorderRadius.horizontal(
              right: Radius.circular(r.sp(5)),
            ),
            border: Border(
              bottom: BorderSide(color: accent.shadow, width: r.sp(1)),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: r.sp(5.2),
              fontWeight: FontWeight.w700,
              letterSpacing: r.sp(0.1),
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}