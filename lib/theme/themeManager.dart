import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

ThemeData light = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.indigo,
    accentColor: Colors.indigo,
    scaffoldBackgroundColor: Color(0xfff1f1f1));

ThemeData dark = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.indigo,
  accentColor: Colors.indigo,
);

class ThemeNotifier extends ChangeNotifier {
  final String key = 'theme';
  bool _darkTheme;


  bool get darkTheme => _darkTheme;
  ThemeNotifier() {
    controllerFons();
  }

  void trueTheme() async {
    await Hive.openBox('theme');
    var box = Hive.box('theme');
    await box.put('darktheme', true);
    _darkTheme = true;
    notifyListeners();
  }

  void getValue() async {
    await Hive.openBox('theme');
    var box = Hive.box('theme');
    _darkTheme = await box.get('darktheme');
  }

  void falseTheme() async {
    await Hive.openBox('theme');
    var box = await Hive.box('theme');
    await box.put('darktheme', false);
    _darkTheme = false;
    notifyListeners();
  }

  void controllerFons() async{
    await Hive.openBox('theme');
    var box = await Hive.box('theme');
    _darkTheme = await box.get('darktheme');
    notifyListeners();
  }

  void toggleTheme(bool isDarkMode) {
    controllerFons();
    isDarkMode ? trueTheme() : falseTheme();
  }
}
