import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';
import 'navbar_item.dart';

class AppNavbar extends StatelessWidget {
  final List<IconData> icons;
  final List<String> labels;
  final int currentIndex;
  final ValueChanged<int> onSelected;

  const AppNavbar({
    super.key,
    required this.icons,
    required this.labels,
    required this.currentIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.border, width: r.sp(0.5)),
        ),
      ),
      // SafeArea di dalam Container agar area gesture bar ikut berwarna.
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: r.sp(1.5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int i = 0; i < icons.length; i++)
                NavbarItem(
                  icon: icons[i],
                  label: labels[i],
                  isActive: i == currentIndex,
                  onTap: () => onSelected(i),
                ),
            ],
          ),
        ),
      ),
    );
  }
}