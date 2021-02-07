import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:humantiy/core/locator.dart';
import 'package:humantiy/screens/splash_page.dart';
import 'package:humantiy/theme/app_state_notify.dart';
import 'package:humantiy/theme/app_theme.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  setUpLocators();
  await Hive.initFlutter();
  runApp(ChangeNotifierProvider<AppStateNotifier>(
    create: (context) => AppStateNotifier(),
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Future getShared() async {
    await Hive.openBox('theme');
    var box = await Hive.box('theme');
    var _themeColor = await box.get('darktheme');

    _themeColor != null
        ? Provider.of<AppStateNotifier>(context, listen: false)
            .updateTheme(_themeColor)
        : Provider.of<AppStateNotifier>(context, listen: false)
            .updateTheme(false);
  }

  @override
  void initState() {
    getShared();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateNotifier>(
      builder: (context, appState, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          // ThemeData(primarySwatch: Colors.blue),
          darkTheme: AppTheme.darkTheme,
          // ThemeData(primarySwatch: Colors.blue),
          themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: SplashPage(),
        );
      },
    );
  }
}
