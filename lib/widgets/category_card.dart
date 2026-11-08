import 'package:flutter/material.dart';

import '../models/quiz_category.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';
import 'chunky_container.dart';

class CategoryCard extends StatelessWidget {
  final QuizCategory category;
  final VoidCallback onTap;
  final int accentIndex; // 0-4, memilih warna lencana
  final int? rank; // jika diisi, lencana menampilkan nomor peringkat

  const CategoryCard({
    super.key,
    required this.category,
    required this.onTap,
    this.accentIndex = 0,
    this.rank,
  });

  String _formatNumber(int n) {
    return n.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (_) => '.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final accent = AppColors.accent(accentIndex);
    final badgeSize = r.sp(12);
    final badgeText = rank != null
        ? '$rank'
        : category.name.substring(0, 1).toUpperCase();

    return ChunkyContainer(
      onTap: onTap,
      color: accent.soft,
      shadowColor: accent.shadow,
      borderColor: accent.main,
      borderWidth: r.sp(0.5),
      depth: r.sp(1),
      radius: r.sp(4),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(r.sp(3.5)),
      child: Row(
        children: [
          Container(
            width: badgeSize,
            height: badgeSize,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: accent.main,
              borderRadius: BorderRadius.circular(r.sp(3)),
              border: Border(
                bottom: BorderSide(color: accent.shadow, width: r.sp(0.8)),
              ),
            ),
            child: Text(
              badgeText,
              style: TextStyle(
                fontSize: r.sp(5.5),
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: r.sp(3.5)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  category.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: r.sp(4.2),
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
                SizedBox(height: r.sp(0.8)),
                Text(
                  category.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: r.sp(3.3),
                    color: AppColors.textMuted,
                  ),
                ),
                SizedBox(height: r.sp(1.2)),
                Text(
                  '${_formatNumber(category.plays)} pemain',
                  style: TextStyle(
                    fontSize: r.sp(3.2),
                    fontWeight: FontWeight.w500,
                    color: accent.shadow,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
