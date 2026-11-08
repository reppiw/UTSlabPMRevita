import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';

/// Membatasi lebar konten dan memusatkannya di layar lebar.
/// Seluruh aplikasi (termasuk dialog) berjalan di dalam bingkai ini.
class AdaptiveFrame extends StatelessWidget {
  final Widget child;

  const AdaptiveFrame({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final size = mq.size;

    final isLandscape = size.width > size.height;
    final maxWidth = isLandscape
        ? Breakpoints.maxLandscapeContent
        : Breakpoints.maxPortraitContent;
    final width = math.min(size.width, maxWidth);

    return ColoredBox(
      color: AppColors.outerBackground,
      child: Center(
        child: SizedBox(
          width: width,
          height: size.height,
          // Semua r.w / r.h / r.sp kini dihitung dari lebar bingkai ini.
          child: MediaQuery(
            data: mq.copyWith(size: Size(width, size.height)),
            child: ColoredBox(
              color: AppColors.background,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}