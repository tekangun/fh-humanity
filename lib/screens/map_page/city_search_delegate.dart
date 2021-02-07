import 'package:flutter/material.dart';
import 'package:humantiy/constants.dart';

class CitySearchDelegate extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
        textTheme: TextTheme(
            bodyText1: TextStyle(
          color: Colors.white,
        )),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
            hintStyle: TextStyle(color: Colors.grey.shade200, fontSize: 14),
            border: InputBorder.none,
            labelStyle: TextStyle(color: Colors.white)));
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    citys.sort();
    return Scrollbar(
      radius: Radius.circular(16),
      child: ListView.builder(
        itemCount: citys.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              citys[index],
              style: TextStyle(color: Colors.black),
            ),
            trailing: Icon(Icons.navigate_next, color: Colors.black),
            onTap: () {},
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Scrollbar(
      radius: Radius.circular(16),
      child: ListView.builder(
        itemCount: citys.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              citys[index],
              style: TextStyle(color: Colors.black),
            ),
            trailing: Icon(Icons.navigate_next, color: Colors.black),
            onTap: () {},
          );
        },
      ),
    );
  }
}
