import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong/latlong.dart';

class BarajMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BarajMainState();
}

class BarajMainState extends State<BarajMain> {
  @override
  Widget build(BuildContext context) {
    return Center(
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
    );
  }
}
