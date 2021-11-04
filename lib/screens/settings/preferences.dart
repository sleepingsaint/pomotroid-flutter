import 'package:flutter/material.dart';
import 'package:pomotroid/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class PreferenceSettings extends StatefulWidget {
  const PreferenceSettings({Key? key}) : super(key: key);

  @override
  _PreferenceSettingsState createState() => _PreferenceSettingsState();
}

class _PreferenceSettingsState extends State<PreferenceSettings> {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<SettingsProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text("Settings"),
          workWidget(model),
          breakWidget(model),
          notificationWidget(model),
        ],
      ),
    );
  }

  Widget breakWidget(SettingsProvider model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Auto-start Break Timer"),
        Checkbox(
          value: model.autoStartBreakTimer,
          onChanged: (value) => model.autoStartBreakTimer = value ?? true,
        )
      ],
    );
  }

  Widget workWidget(SettingsProvider model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Auto-start Work Timer"),
        Checkbox(
          value: model.autoStartWorkTimer,
          onChanged: (value) => model.autoStartWorkTimer = value ?? true,
        ),
      ],
    );
  }

  Widget notificationWidget(SettingsProvider model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Notification"),
        Checkbox(
          value: model.notifications,
          onChanged: (value) => model.notifications = value ?? true,
        )
      ],
    );
  }
}
