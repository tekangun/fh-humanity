import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:humanity/screens/nav_bar/tab_navigator.dart';

class BottomNavBarPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BottomNavBarPageState();
}

class BottomNavBarPageState extends State<BottomNavBarPage> {
  int currentIndex = 0; // to keep track of active tab index
  String currentPage = '';
  List<String> pageKeys = ['Ana Sayfa', 'Ayarlar'];
  Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    'Ana Sayfa': GlobalKey<NavigatorState>(),
    'Ayarlar': GlobalKey<NavigatorState>(),
  };

  Widget _buildOffsetageNavigator(String tabItem) {
    return Offstage(
      offstage: currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }

  void _selectTab(String tabItem, int index) {
    if (mounted) {
      setState(() {
        currentPage = pageKeys[index];
        currentIndex = index;
      });
    }
  }

  @override
  void initState() {
    _selectTab(pageKeys[0], 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            _buildOffsetageNavigator('Ana Sayfa'),
            _buildOffsetageNavigator('Ayarlar'),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            _selectTab(pageKeys[index], index);
          },
          items: [
            BottomNavigationBarItem(
                label: 'Ana Sayfa', icon: Icon(Icons.home)),
            BottomNavigationBarItem(
                label: 'Ayarlar', icon: Icon(Icons.settings)),
          ],
        ));
  }
}
