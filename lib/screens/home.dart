import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong/latlong.dart';
import 'package:humantiy/constants.dart';
import 'package:humantiy/core/locator.dart';
import 'package:humantiy/core/services/data_services.dart';
import 'package:humantiy/core/services/location_services.dart';
import 'package:humantiy/models/air_data_model.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  test() async {
    for (String cityName in citys) {
      var model = getIt<DataServices>(param1: cityName, param2: '');
      AirDataModel tester = await model.getCityData();
      print('Şehir: $cityName ' +
          'Co: ${tester.co} ' +
          'Pm10: ${tester.pm10} ' +
          'pm25: ${tester.pm25} ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: new FlutterMap(
            options: new MapOptions(
              plugins: [
                MarkerClusterPlugin(),
              ],
              zoom: 5.0,
              minZoom: 2.0,
              maxZoom: 20.0,
              center: new LatLng(41, 28),
            ),
            layers: [
              new TileLayerOptions(
                maxZoom: 20,
                urlTemplate:
                    'http://mt{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
                subdomains: ["0", "1", "2", "3"],
                tileProvider: NonCachingNetworkTileProvider(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: test,
      ),
    );
  }
}
