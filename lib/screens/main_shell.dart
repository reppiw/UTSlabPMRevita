import 'package:flutter/material.dart';
import '../widgets/app_navbar.dart';
import 'home_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  // Tambahkan menu di sini saat halamannya sudah dibuat.
  static const _menus = ['Beranda'];
  static const _pages = <Widget>[
    HomePage(),
  ];

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppNavbar(
            items: _menus,
            currentIndex: _index,
            onSelected: (i) => setState(() => _index = i),
          ),
          Expanded(
            child: IndexedStack(
              index: _index,
              children: _pages,
            ),
          ),
        ],
      ),
    );
  }
}