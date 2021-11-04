import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:pomotroid/providers/settings_provider.dart';
import 'package:pomotroid/providers/theme_provider.dart';
import 'package:pomotroid/screens/homepage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DesktopWindow.setMaxWindowSize(const Size(600, 600));
  await DesktopWindow.setMinWindowSize(const Size(400, 600));

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<SettingsProvider>(
          create: (_) => SettingsProvider()),
      ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
    ],
    child: Builder(
      builder: (context) {
        return const HomePage();
      },
    ),
  ));
}
