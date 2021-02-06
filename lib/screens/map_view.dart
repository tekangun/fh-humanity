import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:humantiy/core/services/data_services.dart';
import 'package:humantiy/models/air_data_model.dart';
import 'package:humantiy/screens/info_view.dart';
import 'package:latlong/latlong.dart';

import '../core/locator.dart';

class BarajMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BarajMainState();
}

class BarajMainState extends State<BarajMain> {
  void _handleOnTap(LatLng latlng) {
    final data =
        _getData(latlng.latitude.toString(), latlng.longitude.toString());
    routeInfo(context, data);
  }

  Future<AirDataModel> _getData(String lat, String lng) async {
    var model = getIt<DataServicesFromCoordinate>(
      param1: lat,
      param2: lng,
    );
    final tester = await model.getCityDataFromCoordinate();
    return tester;
  }

  void routeInfo(context, data) {
    final route = MaterialPageRoute(
        builder: (BuildContext context) => DataInfoView(
              data: data
            ));
    Navigator.of(context).push(route);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: FlutterMap(
          options: MapOptions(
            onTap: _handleOnTap,
            plugins: [
              MarkerClusterPlugin(),
            ],
            zoom: 5.0,
            minZoom: 2.0,
            maxZoom: 20.0,
            center: LatLng(41, 28),
          ),
          layers: [
            TileLayerOptions(
              maxZoom: 20,
              urlTemplate:
                  'http://mt{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
              subdomains: ['0', '1', '2', '3'],
              tileProvider: NonCachingNetworkTileProvider(),
            ),
          ],
        ),
      ),
    );
  }
}
