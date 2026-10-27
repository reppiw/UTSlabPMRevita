import 'package:flutter/material.dart';
import '../utils/responsive.dart';

class ProgressHeader extends StatelessWidget {
  final String userName;
  final int current; // nomor soal, mulai dari 1
  final int total;
  final double progress; // 0.0 - 1.0

  const ProgressHeader({
    super.key,
    required this.userName,
    required this.current,
    required this.total,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final primary = Theme.of(context).colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                userName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: r.sp(4.2),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              'Soal $current/$total',
              style: TextStyle(
                fontSize: r.sp(3.6),
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
        SizedBox(height: r.sp(2.5)),
        ClipRRect(
          borderRadius: BorderRadius.circular(r.sp(2)),
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: progress),
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
            builder: (context, value, _) => LinearProgressIndicator(
              value: value,
              minHeight: r.sp(2.5),
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation<Color>(primary),
            ),
         ),
        ),
      ]
    );
  }
}