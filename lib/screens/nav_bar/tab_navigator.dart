import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:humanity/screens/home.dart';
import 'package:humanity/screens/settings.dart';

class TabNavigator extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  const TabNavigator({Key key, this.navigatorKey, this.tabItem})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => TabNavigatorState();
}

class TabNavigatorState extends State<TabNavigator> {



  @override
  Widget build(BuildContext context) {
    Widget child;
    if (widget.tabItem == 'Ana Sayfa') {
      child = Scaffold(
          appBar: AppBar(
            title: Text('Ana Sayfa'),
          ),
          body: Home());
    } else if (widget.tabItem == 'Ayarlar') {
      child = Scaffold(
          appBar: AppBar(
            title: Text('Ayarlar'),
          ),
          body: Settings());
    }

    return Container(
      child: child,
    );
  }
}
