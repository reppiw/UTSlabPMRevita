import 'package:flutter/material.dart';
import '../utils/responsive.dart';
import '../widgets/app_navbar.dart';
import '../widgets/bookmark_label.dart';
import 'history_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  static const _labels = ['Beranda', 'Riwayat', 'Profil'];
  static const _icons = [
    Icons.home_rounded,
    Icons.history_rounded,
    Icons.person_rounded,
  ];
  
  static const _accentIndexes = [4, 1, 3];
  static const _pages = <Widget>[
    HomePage(),
    HistoryPage(),
    ProfilePage(),
  ];

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            SizedBox(height: r.h(2)),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              transitionBuilder: (child, animation) => SlideTransition(
                position: animation.drive(
                  Tween<Offset>(
                    begin: const Offset(-1, 0),
                    end: Offset.zero,
                  ).chain(CurveTween(curve: Curves.easeOutCubic)),
                ),
                child: child,
              ),
              child: BookmarkLabel(
                key: ValueKey(_index),
                text: _labels[_index],
              ),
            ),
            Expanded(
              child: IndexedStack(index: _index, children: _pages),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppNavbar(
        icons: _icons,
        labels: _labels,
        currentIndex: _index,
        onSelected: (i) => setState(() => _index = i),
      ),
    );
  }
}