import 'package:flutter/material.dart';
import 'package:pomotroid/screens/settings/preferences.dart';
import 'package:pomotroid/screens/settings/themes.dart';
import 'package:pomotroid/screens/settings/timer_settings.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  int _idx = 0;
  final List<Widget> _screens = const [
    TimerSettings(),
    PreferenceSettings(),
    ThemeSettings(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pomotroid"),
        centerTitle: true,
      ),
      body: _screens[_idx],
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        currentIndex: _idx,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: "Timer",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "settings",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.color_lens_sharp),
            label: "Themes",
          ),
        ],
        onTap: (index) => setState(() {
          _idx = index;
        }),
      ),
    );
  }
}
