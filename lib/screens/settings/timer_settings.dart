import 'package:flutter/material.dart';
import 'package:pomotroid/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class TimerSettings extends StatefulWidget {
  const TimerSettings({Key? key}) : super(key: key);

  @override
  _TimerSettingsState createState() => _TimerSettingsState();
}

class _TimerSettingsState extends State<TimerSettings> {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<SettingsProvider>(context);
    return Column(
      children: [
        const Text("Timer"),
        const Text("Focus"),

        // focus
        Text("${model.focus} : 00"),
        Slider(
          min: 1,
          max: 90,
          value: model.focus.toDouble(),
          onChanged: (value) => model.focus = value.toInt(),
        ),

        // short break
        Text("${model.shortBreak}: 00"),
        Slider(
          min: 1,
          max: 90,
          value: model.shortBreak.toDouble(),
          onChanged: (value) => model.shortBreak = value.toInt(),
        ),

        // long break
        Text("${model.longBreak} : 00"),
        Slider(
            min: 1,
            max: 90,
            value: model.longBreak.toDouble(),
            onChanged: (value) => model.longBreak = value.toInt()),

        // rounds
        Text("${model.numRounds}"),
        Slider(
          min: 1,
          max: 12,
          value: model.numRounds.toDouble(),
          onChanged: (value) => model.numRounds = value.toInt(),
        ),

        // reset defaults
        TextButton(
          onPressed: model.resetSettings,
          child: const Text("Reset Defaults"),
        )
      ],
    );
  }
}
