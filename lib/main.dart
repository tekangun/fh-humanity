import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:humantiy/core/locator.dart';
import 'package:humantiy/screens/nav_bar/bottom_nav_bar.dart';
import 'package:humantiy/theme/themeManager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  setUpLocators();
  await Hive.initFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            title: 'Flutter Theme Provider',
            theme: notifier.darkTheme ? dark : light,
            home: BottomNavBarPage(),
          );
        },
      ),
    );
  }
}
