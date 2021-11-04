import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:pomotroid/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class ThemeSettings extends StatefulWidget {
  const ThemeSettings({Key? key}) : super(key: key);

  @override
  _ThemeSettingState createState() => _ThemeSettingState();
}

class _ThemeSettingState extends State<ThemeSettings> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ThemeProvider>(context);
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: _themesList(model),
    );
  }

  Widget _themesList(ThemeProvider model) {
    return FutureBuilder(
      future: loadThemes(),
      builder: (context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.hasData) {
          return ListView(
            children: snapshot.data!
                .map((String themeName) => _themeTile(themeName, model))
                .toList(),
          );
        } else if (snapshot.hasError) {
          return const ListTile(title: Text("Oops! something went wrong"));
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget _themeTile(String themeName, ThemeProvider model) {
    return FutureBuilder(
      future: loadThemeData(themeName),
      builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.hasData) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Card(
              color: fromCssColor(snapshot.data!["background"]),
              child: ListTile(
                shape: Border(
                  left: BorderSide(
                    width: 5,
                    color: fromCssColor(snapshot.data!["accent"]),
                  ),
                ),
                title: Text(
                  snapshot.data!["name"],
                  style: TextStyle(
                    color: fromCssColor(snapshot.data!["foreground"]),
                  ),
                ),
                trailing: model.themeName == themeName
                    ? Icon(
                        Icons.check,
                        color: fromCssColor(snapshot.data!["accent"]),
                      )
                    : null,
                onTap: () {
                  model.themeName = themeName;
                  setState(() {});
                },
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return const ListTile(title: Text("Oops! something went wrong"));
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Future<List<String>> loadThemes() async {
    var _themeAssets = await rootBundle.loadString("AssetManifest.json");
    Map<String, dynamic> _jsonThemeAssets = jsonDecode(_themeAssets);

    final _themePaths = _jsonThemeAssets.keys
        .where((String key) => key.contains("themes/"))
        .where((String key) => key.contains(".json"))
        .toList();

    List<String> _themeNames = _themePaths
        .map((path) => path.split("/").last.split(".").first)
        .toList();

    return _themeNames;
  }

  Future<Map<String, dynamic>> loadThemeData(String themeName) async {
    var jsonText = await rootBundle.loadString('assets/themes/$themeName.json');
    Map<String, dynamic> _themeData = jsonDecode(jsonText);
    Map<String, dynamic> _theme = {};
    _theme["name"] = _themeData["name"];
    _theme["accent"] = _themeData["colors"]["--color-accent"];
    _theme["background"] = _themeData["colors"]["--color-background"];
    _theme["foreground"] = _themeData["colors"]["--color-foreground"];

    return _theme;
  }
}
