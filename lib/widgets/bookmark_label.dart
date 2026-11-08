import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';

class BookmarkLabel extends StatelessWidget {
  final String text;

  const BookmarkLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);

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
            color: AppColors.primary,
            // Menempel di kiri: hanya sisi kanan yang melengkung.
            borderRadius: BorderRadius.horizontal(
              right: Radius.circular(r.sp(5)),
            ),
            // Sisi bawah lebih gelap, selaras dengan tombol.
            border: Border(
              bottom: BorderSide(
                color: AppColors.primaryShadow,
                width: r.sp(1),
              ),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: r.sp(5.2),
              fontWeight: FontWeight.w700,
              letterSpacing: r.sp(0.1),
              color: AppColors.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}