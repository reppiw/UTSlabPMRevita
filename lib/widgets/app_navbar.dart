import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';
import 'navbar_item.dart';

class AppNavbar extends StatelessWidget {
  final List<IconData> icons;
  final List<String> labels;
  final int currentIndex;
  final ValueChanged<int> onSelected;
  final Axis axis;

  const AppNavbar({
    super.key,
    required this.icons,
    required this.labels,
    required this.currentIndex,
    required this.onSelected,
    this.axis = Axis.horizontal,
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final vertical = axis == Axis.vertical;

    final items = <Widget>[
      for (int i = 0; i < icons.length; i++)
        NavbarItem(
          icon: icons[i],
          label: labels[i],
          isActive: i == currentIndex,
          onTap: () => onSelected(i),
        ),
    ];

    final borderSide = BorderSide(
      color: AppColors.primaryShadow,
      width: r.sp(1),
    );

    if (vertical) {
      return Container(
        decoration: BoxDecoration(
          color: AppColors.primary,
          border: Border(right: borderSide),
        ),
        child: SafeArea(
          top: false,
          right: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: r.sp(2)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < items.length; i++) ...[
                  if (i > 0) SizedBox(height: r.sp(3)),
                  items[i],
                ],
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primary,
        border: Border(top: borderSide),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: r.sp(1.5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: items,
          ),
        ),
      ),
    );
  }
}