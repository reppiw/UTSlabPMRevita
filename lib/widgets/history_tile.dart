import 'package:flutter/material.dart';
import '../models/history_entry.dart';
import '../models/quiz_mode.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';

class HistoryTile extends StatelessWidget {
  final HistoryEntry entry;

  const HistoryTile({super.key, required this.entry});

  String _two(int n) => n.toString().padLeft(2, '0');

  String get _dateText {
    final d = entry.date;
    return '${_two(d.day)}/${_two(d.month)}/${d.year}  '
        '${_two(d.hour)}:${_two(d.minute)}';
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final badgeSize = r.sp(15);

    return Container(
      margin: EdgeInsets.only(bottom: r.sp(2.5)),
      padding: EdgeInsets.all(r.sp(3.5)),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(r.sp(4)),
        border: Border.all(color: AppColors.border, width: r.sp(0.5)),
      ),
      child: Row(
        children: [
          Container(
            width: badgeSize,
            height: badgeSize,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(r.sp(3)),
            ),
            child: Text(
              '${entry.score}/${entry.total}',
              style: TextStyle(
                fontSize: r.sp(3.8),
                fontWeight: FontWeight.w700,
                color: AppColors.onPrimary,
              ),
            ),
          ),
          SizedBox(width: r.sp(3.5)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.categoryName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: r.sp(4.2),
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
                SizedBox(height: r.sp(0.8)),
                Text(
                  '${entry.userName} • Level ${entry.difficulty} • ${entry.mode.label}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: r.sp(3.2),
                    color: AppColors.textMuted,
                  ),
                ),
                SizedBox(height: r.sp(0.8)),
                Text(
                  _dateText,
                  style: TextStyle(
                    fontSize: r.sp(3),
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: r.sp(2)),
          Text(
            '${entry.percent}',
            style: TextStyle(
              fontSize: r.sp(6),
              fontWeight: FontWeight.w700,
              color: AppColors.primaryShadow,
            ),
          ),
        ],
      ),
    );
  }
}