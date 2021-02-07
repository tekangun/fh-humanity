import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:hive/hive.dart';
import 'package:humantiy/constants.dart';
import 'package:humantiy/core/services/data_services.dart';
import 'package:humantiy/models/air_data_model.dart';
import 'package:humantiy/screens/info_view.dart';
import 'package:humantiy/screens/map_page/city_search_delegate.dart';
import 'package:latlong/latlong.dart';

import '../../core/locator.dart';

class MapView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MapViewState();
}

class MapViewState extends State<MapView> {
  var markerList = <Marker>[];

  @override
  void initState() {
    _loadDefaults();
    super.initState();
  }

  Future _getLocalArea() async {
    await Hive.openBox('myLocationsDb');
    var box = Hive.box('myLocationsDb');
    var savedAreas = await box.get('savedAreas');
    return savedAreas;
  }

  void _loadDefaults() async {

  }

  void _saveAreaToLocal(data) async {
    await Hive.openBox('myLocationsDb');
    var box = Hive.box('myLocationsDb');
    var savedAreas = await box.get('savedAreas');
    var newSaveArea = compileAreaDataForSave(await data);
    savedAreas != null ? savedAreas.add(newSaveArea[0]) : null;
    var lastSavedData = savedAreas ?? newSaveArea;
    print(lastSavedData);
    await box.put('savedAreas', lastSavedData);
    if (mounted) {
      setState(() {
        isSavedNewArea = true;
      });
    }
    Navigator.pop(context);
  }

  List<dynamic> compileAreaDataForSave(AirDataModel airDataModel) {
    var tempSavedAreas = [];
    tempSavedAreas
        .insert(0, [airDataModel.lat, airDataModel.lng, airDataModel.name, airDataModel.aqi]);
    return tempSavedAreas;
  }

  Future<void> _handleOnTap(LatLng latlng) async {
    final data =
        await _getData(latlng.latitude.toString(), latlng.longitude.toString());
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
              title: Text('${data.name}'),
              content: Text(
                'Hava Kalitesi: ${data.aqi}\nKarbonmonoksit: ${data.co}\nPm25: ${data.pm25}\nPm10: ${data.pm10}\nGüncelleme: ${data.time}',
                // textAlign: TextAlign.justify,
              ),
              actions: [
                FlatButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Kapat')),
                FlatButton(
                    onPressed: () => _saveAreaToLocal(data),
                    child: Text('Kaydet'))
              ],
            ));
  }

  Future<AirDataModel> _getData(String lat, String lng) async {
    var model = getIt<DataServicesFromCoordinate>(
      param1: lat,
      param2: lng,
    );
    final selectedAreaData = await model.getCityDataFromCoordinate();
    return selectedAreaData;
  }

  void routeInfo(context, data) {
    final route = MaterialPageRoute(
        builder: (BuildContext context) => DataInfoView(data: data));
    Navigator.of(context).push(route);
  }

  @override
  Widget build(BuildContext context) {
    final futureBuilder = FutureBuilder(
        future: _getLocalArea(),
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
                return buildFlutterMap(snapshot);
                // return showInfo(context, snapshot);
              }
          }
        });
    return Scaffold(
      appBar: AppBar(
        title: Text('humanity'),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () {
                showSearch(
                  context: context,
                  delegate: CitySearchDelegate(),
                );
              },
              child: Icon(Icons.search),
            ),
          )
        ],
      ),
      body: Center(child: Container(child: futureBuilder)),
      // body: Center(
      //   child: Container(
      //     child: buildFlutterMap(),
      //   ),
      // ),
    );
  }

  Color getColor(aqi) {
    var color = Colors.white;
    if (double.parse(aqi.toString()) <= 50) {
      color = Colors.green;
    } else if (double.parse(aqi.toString()) > 50 || double.parse(aqi.toString()) <= 100) {
      color = Colors.yellow[700];
    } else if (double.parse(aqi.toString()) > 100 || double.parse(aqi.toString()) <= 150) {
      color = Colors.deepOrange;
    } else if (double.parse(aqi.toString()) > 150 || double.parse(aqi.toString()) <= 200) {
      color = Colors.red;
    } else if (double.parse(aqi.toString()) > 200 || double.parse(aqi.toString()) <= 300) {
      color = Colors.purple;
    } else if (double.parse(aqi.toString()) > 200 || double.parse(aqi.toString()) <= 300) {
      color = Colors.purple[900];
    }
    return color;
  }

  void createMarkers(data) {
    var newMarker = Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(data[0], data[1]),
      builder: (context) => Container(
          child: Column(
        children: <Widget>[
          Icon(
            Icons.location_on,
            color: getColor(data[data.length-1]),
            size: 50,
          ),
        ],
      )),
    );
    markerList.add(newMarker);
  }

  FlutterMap buildFlutterMap(AsyncSnapshot snapshot) {
    markerList = <Marker>[];
    var data = snapshot.data;
    data.forEach((location) => createMarkers(location));
    return FlutterMap(
      options: MapOptions(
        onTap: _handleOnTap,
        plugins: [
          MarkerClusterPlugin(),
        ],
        zoom: 5.0,
        minZoom: 2.0,
        maxZoom: 20.0,
        center: LatLng(39.179565, 34.455683),
      ),
      layers: [
        TileLayerOptions(
          maxZoom: 20,
          urlTemplate: 'http://mt{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
          subdomains: ['0', '1', '2', '3'],
          tileProvider: NonCachingNetworkTileProvider(),
        ),
        MarkerLayerOptions(markers: markerList)
      ],
    );
  }
}
