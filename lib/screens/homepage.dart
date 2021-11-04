import 'package:flutter/material.dart';
import 'package:pomotroid/providers/theme_provider.dart';
import 'package:pomotroid/screens/settings.dart';
import 'package:pomotroid/screens/timer.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (context) => const TimerScreen(),
        "/settings": (context) => const SettingScreen()
      },
      initialRoute: "/",
      theme: ThemeData.dark(),
    );
  }
}
