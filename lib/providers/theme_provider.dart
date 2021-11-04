import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomTheme {
  Color? accent;
  Color? background1, background2, background;
  Color? foreground, foreground1, foreground2;
  Color? focus, short, long;

  CustomTheme({
    this.accent,
    this.background,
    this.background1,
    this.background2,
    this.foreground,
    this.foreground1,
    this.foreground2,
    this.focus,
    this.short,
    this.long,
  });
}

class ThemeProvider extends ChangeNotifier {
  SharedPreferences? _preferences;
  String _themeName = "pomotroid";
  CustomTheme? _theme;

  String get themeName => _themeName;
  CustomTheme? get theme => _theme;

  ThemeProvider() {
    init();
  }

  loadPref() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  init() async {
    await loadPref();
    _themeName = _preferences?.getString("theme") ?? "pomotroid";
    loadThemeData(_themeName);
    notifyListeners();
  }

  set themeName(String value) {
    _themeName = value;
    _preferences?.setString("theme", value);
    loadThemeData(value);
    notifyListeners();
  }

  void loadThemeData(String themeName) async {
    var jsonText = await rootBundle.loadString('assets/themes/$themeName.json');
    Map<String, dynamic> _data = jsonDecode(jsonText);
    Color _background = fromCssColor(_data["colors"]["--color-background"]);
    Color _background1 =
        fromCssColor(_data["colors"]["--color-background-light"]);
    Color _background2 =
        fromCssColor(_data["colors"]["--color-background-lightest"]);

    Color _foreground = fromCssColor(_data["colors"]["--color-foreground"]);
    Color _foreground1 =
        fromCssColor(_data["colors"]["--color-foreground-darker"]);
    Color _foreground2 =
        fromCssColor(_data["colors"]["--color-foreground-darkest"]);
    Color _accent = fromCssColor(_data["colors"]["--color-accent"]);
    Color _long = fromCssColor(_data["colors"]["--color-long-round"]);
    Color _short = fromCssColor(_data["colors"]["--color-short-round"]);
    Color _focus = fromCssColor(_data["colors"]["--color-focus-round"]);

    _theme = CustomTheme(
      accent: _accent,
      background: _background,
      background1: _background1,
      background2: _background2,
      foreground: _foreground,
      foreground1: _foreground1,
      foreground2: _foreground2,
      focus: _focus,
      long: _long,
      short: _short,
    );
    notifyListeners();
  }
}
