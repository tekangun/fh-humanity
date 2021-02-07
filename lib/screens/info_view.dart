import 'package:flutter/material.dart';

class DataInfoView extends StatefulWidget {
  final Future data;
  DataInfoView({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  _DataInfoViewState createState() => _DataInfoViewState();
}

class _DataInfoViewState extends State<DataInfoView> {
  void _onButtonPressed() {
    // kaydet fonksiyonu
    // liste şeklinde kaydedilen noktalar oluşturulur
    print('kaydet fonksiyonu');
  }

  @override
  Widget build(BuildContext context) {
    final futureBuilder = FutureBuilder(
        future: widget.data,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else {
                return showInfo(context, snapshot);
              }
          }
        });
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Humantiy',
              style: TextStyle(color: Colors.black87),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.save,
                  color: Colors.black87,
                  size: 20,
                ),
                onPressed: () => _onButtonPressed(),
              ),
            ],
          ),
          body: Center(child: Container(child: futureBuilder)),
        ),
      ),
    );
  }

  Widget showInfo(BuildContext context, AsyncSnapshot snapshot) {
    return Text('${snapshot.data.co} ${snapshot.data.name}');
  }
}
