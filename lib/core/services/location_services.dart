import 'package:flutter/services.dart';
import 'package:location/location.dart';

class LocationServices {
  var location = Location();
  Future<LocationData> getPosition() async {
    /// Latitude: 37.9324002, Longitude: 40.1843365
    bool serviceEnabled;
    PermissionStatus permission;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        await SystemNavigator.pop();
        return Future.error('Location services are disabled.');
      }
    }
    permission = await location.hasPermission();
    if (permission == PermissionStatus.deniedForever) {
      await SystemNavigator.pop();
      return Future.error('denied');
    }
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission != PermissionStatus.granted) {
        await SystemNavigator.pop();
        return Future.error('denied forever');
      }
    }
    return await location.getLocation();
  }
}
