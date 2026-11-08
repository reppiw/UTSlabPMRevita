import 'package:flutter/material.dart';
import '../widgets/app_navbar.dart';
import 'history_screen.dart';
import 'home_screen.dart';

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
  static const _pages = <Widget>[
    HomePage(),
    HistoryPage(),
  ];

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Navbar di bawah. SafeArea atas menjaga isi dari status bar.
      body: SafeArea(
        bottom: false,
        child: IndexedStack(index: _index, children: _pages),
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