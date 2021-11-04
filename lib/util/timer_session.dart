class TimerSession {
  final Duration _focus = const Duration(minutes: 25);
  final Duration _shortBreak = const Duration(minutes: 5);
  final Duration _longBreak = const Duration(minutes: 15);

  int _numSessions = 0;
  bool _focusTime = true;
  String _state = "focus";

  Duration get currentDuration {
    if (_focusTime) {
      return _focus;
    } else if (_numSessions % 4 == 0) {
      return _longBreak;
    }
    return _shortBreak;
  }

  String get currentStatus {
    if (_focusTime) {
      return "FOCUS";
    } else if (_numSessions % 4 == 0) {
      return "LONG BREAK";
    }

    return "SHORT BREAK";
  }

  bool get focusTime => _focusTime;
  String get state => _state;

  int get numSessions {
    return _numSessions;
  }

  void increment() {
    if (_focusTime) {
      _numSessions++;
    }

    _focusTime = !_focusTime;

    if (_focusTime) {
      _state = "focus";
    } else if (_numSessions % 4 == 0) {
      _state = "long";
    } else {
      _state = "short";
    }
  }
}
