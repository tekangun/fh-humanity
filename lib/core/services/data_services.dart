import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:humantiy/constants.dart';
import 'package:humantiy/models/air_data_model.dart';

class DataServices {
  final String cityName;

  DataServices({this.cityName});

  Future<AirDataModel> getCityData() async {
    var url = "https://api.waqi.info/feed/$cityName/?token=$airToken";
    var response = await http.get(url).catchError((error) => print(error));
    return AirDataModel.fromSnapshots(airDataMap: jsonDecode(response.body));
  }
}

class DataServicesBaraj {
  Future<BarajDataModel> getBarajData() async {
    var url =
        "https://acikveri.bizizmir.com/tr/api/3/action/datastore_search_sql?sql=SELECT%20*%20from%20%225c2ad5b0-f681-45a6-b72c-170791ea8f50%22%20ORDER%20BY%20%22DURUM_TARIHI%22%20DESC%20LIMIT%2015";
    var response = await http
        .get(url)
        .catchError((error) => print(error.toString() + "burası"));
    return BarajDataModel.fromSnapshots(
        barajDataMap: jsonDecode(response.body));
  }
}
