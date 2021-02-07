import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:humantiy/screens/map_page/map_view.dart';
import 'package:humantiy/screens/home.dart';
import 'package:humantiy/screens/settings.dart';

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
            title: Text('humanity'),
          ),
          body: Home());
    } else if (widget.tabItem == 'Harita') {
      child = MapView();
    } else if (widget.tabItem == 'Ayarlar') {
      child = Scaffold(
          appBar: AppBar(
            title: Text('humanity'),
          ),
          body: Settings());
    }

    return Container(
      child: child,
    );
  }
}
