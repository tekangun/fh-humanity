import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:humantiy/core/locator.dart';
import 'package:humantiy/screens/nav_bar/bottom_nav_bar.dart';

Future<void> main()async {
  setUpLocators();
  await Hive.initFlutter(); 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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