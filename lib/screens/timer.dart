import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pomotroid/providers/theme_provider.dart';
import 'package:pomotroid/util/timer_session.dart';
import 'package:provider/provider.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  Timer? _timer;
  Duration _counter = const Duration(minutes: 25);
  final Duration _oneSec = const Duration(seconds: 1);
  final Duration _zeroSec = const Duration(seconds: 0);
  final TimerSession _timerSession = TimerSession();

  @override
  void initState() {
    super.initState();
    _counter = _timerSession.currentDuration;
    // _initTimer();
  }

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pomotroid"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => {
            Navigator.of(context).pushNamed("/settings"),
          },
          icon: const Icon(Icons.menu),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 2 * MediaQuery.of(context).size.width / 3,
                  height: 2 * MediaQuery.of(context).size.width / 3,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CircularProgressIndicator(
                        value: _counter.inSeconds / 20,
                        backgroundColor: Colors.amber,
                        color: _timerSession.state == "focus"
                            ? themeModel.theme!.focus
                            : _timerSession.state == "long"
                                ? themeModel.theme!.long
                                : themeModel.theme!.short,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "${_counter.inMinutes.toString().padLeft(2, '0')} : ${(_counter.inSeconds % 60).toString().padLeft(2, '0')}",
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).textScaleFactor * 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            _timerSession.currentStatus,
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).textScaleFactor *
                                        22),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Center(
                  child: IconButton(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    onPressed: () => {
                      setState(() {
                        if (_timer != null && _timer!.isActive) {
                          _timer?.cancel();
                        } else {
                          _initTimer();
                        }
                      })
                    },
                    icon: _timer != null && _timer!.isActive
                        ? const Icon(
                            Icons.pause_circle_outline,
                            size: 50,
                          )
                        : const Icon(Icons.play_circle_outline, size: 50),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  label: const Text("Reset"),
                  onPressed: _resetTimer,
                  icon: const Icon(Icons.restore),
                ),
                Text("${_timerSession.numSessions}"),
                TextButton.icon(
                  onPressed: _skipNext,
                  icon: const Icon(Icons.skip_next),
                  label: const Text("Skip"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _initTimer() {
    _timer = Timer.periodic(_oneSec, (timer) {
      if (_counter == _zeroSec) {
        setState(() {
          _timer?.cancel();
        });
      } else {
        setState(() {
          _counter -= _oneSec;
        });
      }
    });
  }

  void _resetTimer() {
    setState(() {
      _timer?.cancel();
      _counter = _timerSession.currentDuration;
    });
  }

  void _skipNext() {
    setState(() {
      _timer?.cancel();
      _timerSession.increment();
      _counter = _timerSession.currentDuration;
      _initTimer();
    });
  }
}
