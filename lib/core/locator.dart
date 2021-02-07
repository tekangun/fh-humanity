import 'package:get_it/get_it.dart';
import 'package:humantiy/core/services/data_services.dart';
import 'package:humantiy/core/services/location_services.dart';
import 'services/data_services.dart';

GetIt getIt = GetIt.instance;

void setUpLocators() {
  getIt.registerLazySingleton(() => LocationServices());

  getIt.registerFactoryParam<DataServicesFromCoordinate, String, String>(
      (_lat, _lng) => DataServicesFromCoordinate(lat: _lat,lng: _lng));

  getIt.registerFactoryParam<DataServices, String, String>(
      (cityName, info) => DataServices(cityName: cityName));

}
