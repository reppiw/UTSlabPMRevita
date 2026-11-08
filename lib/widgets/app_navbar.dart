import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';
import 'navbar_item.dart';

class AppNavbar extends StatelessWidget {
  final List<String> items;
  final int currentIndex;
  final ValueChanged<int> onSelected;

  const AppNavbar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final logoSize = r.sp(10);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          bottom: BorderSide(color: AppColors.border, width: r.sp(0.5)),
        ),
      ),
      // SafeArea di dalam Container supaya area status bar ikut berwarna.
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: r.w(4),
            vertical: r.sp(1.5),
          ),
          child: Row(
            children: [
              Image.asset(
                'assets/images/quiz_logo.png',
                height: logoSize,
                width: logoSize,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) =>
                    SizedBox(height: logoSize, width: logoSize),
              ),
              if (r.isLandscape) ...[
                SizedBox(width: r.w(1.5)),
                Text(
                  'KuisKu',
                  style: TextStyle(
                    fontSize: r.sp(4.5),
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ],
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (int i = 0; i < items.length; i++)
                          NavbarItem(
                            label: items[i],
                            isActive: i == currentIndex,
                            onTap: () => onSelected(i),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}