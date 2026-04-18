import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/reports_screen.dart';
import '../screens/settings_screen.dart';
import '../theme/app_theme.dart';

class MainNav extends StatefulWidget {
  @override
  _MainNavState createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int _index = 0;
  final List<Widget> _tabs = [HomeScreen(), Center(child: Text("Reports Log")), SettingsScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cradle Protection"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _tabs[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (val) => setState(() => _index = val),
        selectedItemColor: const Color(0xFF9DB08B),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Reports"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}