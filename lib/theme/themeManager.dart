import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

ThemeData light = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.indigo,
    accentColor: Colors.pink,
    scaffoldBackgroundColor: Color(0xfff1f1f1));

ThemeData dark = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.indigo,
  accentColor: Colors.pink,
);

class ThemeNotifier extends ChangeNotifier {
  final String key = 'theme';
  bool _darkTheme;

  bool get darkTheme => _darkTheme;
  ThemeNotifier() {
    controllerFons();
  }

  trueTheme() async {
    await Hive.openBox('theme');
    var box = Hive.box('theme');
    await box.put('_darktheme', true);
    _darkTheme = await box.get('_darktheme');
    notifyListeners();
  }

  getValue() async {
    await Hive.openBox('theme');
    var box = Hive.box('theme');
    _darkTheme = await box.get('_darktheme');
  }

  falseTheme() async {
    await Hive.openBox('theme');
    var box = Hive.box('theme');
    await box.put('_darktheme', false);
    _darkTheme = await box.get('_darktheme');
    notifyListeners();
  }

  controllerFons() {
    if (_darkTheme == null) {
      falseTheme();
    }
  }

  toggleTheme() {
    controllerFons();
    _darkTheme ? falseTheme() : trueTheme();
  }
}
