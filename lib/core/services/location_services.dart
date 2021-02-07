import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

class LocationServices {
  Future<Position> getPosition() async {
    /// Latitude: 37.9324002, Longitude: 40.1843365
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await SystemNavigator.pop();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      await SystemNavigator.pop();
      return Future.error('denied');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        await SystemNavigator.pop();
        return Future.error('denied forever');
      }
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.medium, forceAndroidLocationManager: true);
  }
}
