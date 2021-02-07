import 'package:flutter/material.dart';

class AppTheme {
  //
  AppTheme._();

  static final lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      centerTitle: true,
    ),
      brightness: Brightness.light,
      primarySwatch: Colors.indigo,
      accentColor: Colors.indigo,
      scaffoldBackgroundColor: Color(0xfff1f1f1));

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.indigoAccent,
    accentColor: Colors.indigoAccent,
  );
}
