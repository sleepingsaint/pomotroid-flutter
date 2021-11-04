import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  SharedPreferences? _preferences;

  // settings
  int _focus = 25;
  int _shortBreak = 4;
  int _longBreak = 15;
  int _numRounds = 4;

  // preferences
  bool _autoStartWorkTimer = false;
  bool _autoStartBreakTimer = false;
  bool _notifications = false;

  bool get autoStartWorkTimer => _autoStartWorkTimer;
  bool get autoStartBreakTimer => _autoStartBreakTimer;
  bool get notifications => _notifications;

  int get focus => _focus;
  int get shortBreak => _shortBreak;
  int get longBreak => _longBreak;
  int get numRounds => _numRounds;

  SettingsProvider() {
    init();
  }

  loadPref() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  init() async {
    await loadPref();
    _focus = _preferences?.getInt("focus") ?? 35;
    _shortBreak = _preferences?.getInt("short") ?? 4;
    _longBreak = _preferences?.getInt("long") ?? 15;
    _numRounds = _preferences?.getInt("rounds") ?? 4;

    // loading saved preferences
    _autoStartBreakTimer = _preferences?.getBool("break") ?? true;
    _autoStartWorkTimer = _preferences?.getBool("work") ?? true;
    _notifications = _preferences?.getBool("notifications") ?? true;

    notifyListeners();
  }

  set focus(int value) {
    _focus = value;
    _preferences?.setInt("focus", value);
    notifyListeners();
  }

  set shortBreak(int value) {
    _shortBreak = value;
    _preferences?.setInt("short", value);
    notifyListeners();
  }

  set longBreak(int value) {
    _longBreak = value;
    _preferences?.setInt("long", value);
    notifyListeners();
  }

  set numRounds(int value) {
    _numRounds = value;
    _preferences?.setInt("rounds", value);
    notifyListeners();
  }

  set autoStartBreakTimer(bool value) {
    _autoStartBreakTimer = value;
    _preferences?.setBool("break", value);
    notifyListeners();
  }

  set autoStartWorkTimer(bool value) {
    _autoStartWorkTimer = value;
    _preferences?.setBool("work", value);
    notifyListeners();
  }

  set notifications(bool value) {
    _notifications = value;
    _preferences?.setBool("notifications", value);
    notifyListeners();
  }

  void resetSettings() {
    _focus = 25;
    _shortBreak = 5;
    _longBreak = 15;
    _numRounds = 4;

    _preferences?.setInt("focus", _focus);
    _preferences?.setInt("short", _shortBreak);
    _preferences?.setInt("long", _longBreak);
    _preferences?.setInt("rounds", _numRounds);

    notifyListeners();
  }

  void resetPreferenceSettings() {
    _autoStartBreakTimer = true;
    _autoStartWorkTimer = true;
    _notifications = true;

    _preferences?.setBool("break", _autoStartBreakTimer);
    _preferences?.setBool("work", _autoStartWorkTimer);
    _preferences?.setBool("notifications", _notifications);

    notifyListeners();
  }
}
