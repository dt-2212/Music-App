import 'package:flutter/material.dart';
import 'package:music_app/ui/settings_tab/settings_tab.dart';

import 'account_tab/account_tab.dart';
import 'home_tab/home_tab.dart';
import 'library_tab/library_tab.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final List<Widget> _tabs = [
    const HomeTab(),
    const LibraryTab(),
    const AccountTab(),
    const SettingsTab(),
  ];
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [Colors.blue, Colors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          tileMode: TileMode.clamp,
        )),
        child: BottomNavigationBar(
          onTap: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          showUnselectedLabels: false,
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          currentIndex: currentPageIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black54,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.widgets_rounded), label: 'Library'),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Account'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
          ],
        ),
      ),
      body: _tabs[currentPageIndex],
    );
  }
}
