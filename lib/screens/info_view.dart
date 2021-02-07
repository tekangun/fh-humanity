import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:humantiy/constants.dart';
import 'package:humantiy/models/air_data_model.dart';

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
  var box = Hive.box('myLocationsDb');

  List<dynamic> compileAreaDataForSave(AirDataModel airDataModel) {
    var tempSavedAreas = [];
    tempSavedAreas
        .insert(0, [airDataModel.lat, airDataModel.lng, airDataModel.name]);
    return tempSavedAreas;
  }

  void _saveAreaToLocal() async {
    var savedAreas = await box.get('savedAreas');
    var newSaveArea = compileAreaDataForSave(await widget.data);
    savedAreas != null ? savedAreas.add(newSaveArea[0]) : null;
    var lastSavedData = savedAreas ?? newSaveArea;
    print(lastSavedData);
    await box.put('savedAreas', lastSavedData);
   if(mounted){
     setState(() {
       isSavedNewArea = true;
     });
   }
   Navigator.pop(context);
  }

  void _loadDefaults() async {
    await Hive.openBox('myLocationsDb');
  }

  @override
  void initState() {
    _loadDefaults();
    super.initState();
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
                onPressed: () => _saveAreaToLocal(),
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
