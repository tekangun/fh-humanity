import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:humanity/core/locator.dart';
import 'package:humanity/screens/nav_bar/bottom_nav_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main()async {
  setUpLocators();
  await Hive.initFlutter(); // Flutter uygulamaları için
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BottomNavBarPage(),
    );
  }
}