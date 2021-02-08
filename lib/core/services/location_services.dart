import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:location/location.dart';

class LocationServices {
  var location = Location();
  Future<geolocator.Position> getPosition() async {
    /// Latitude: 37.9324002, Longitude: 40.1843365
    bool serviceEnabled;
    geolocator.LocationPermission permission;

    permission = await geolocator.Geolocator.checkPermission();
    if (permission == geolocator.LocationPermission.deniedForever) {
      await SystemNavigator.pop();
      return Future.error('denied');
    }

    if (permission == geolocator.LocationPermission.denied) {
      permission = await geolocator.Geolocator.requestPermission();
      if (permission != geolocator.LocationPermission.whileInUse &&
          permission != geolocator.LocationPermission.always) {
        await SystemNavigator.pop();
        return Future.error('denied forever');
      }
    }

    serviceEnabled = await geolocator.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        await SystemNavigator.pop();
        return Future.error('Location services are disabled.');
      }
    }

    return await geolocator.Geolocator.getCurrentPosition(
        desiredAccuracy: geolocator.LocationAccuracy.medium,
        forceAndroidLocationManager: true);
  }
}
