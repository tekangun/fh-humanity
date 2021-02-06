import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:humantiy/constants.dart';
import 'package:humantiy/models/air_data_model.dart';

class DataServices {
  final String cityName;

  DataServices({this.cityName});

  Future<AirDataModel> getCityData() async {
    var url = 'https://api.waqi.info/feed/$cityName/?token=$airToken';
    var response = await http.get(url).catchError((error) => print(error));
    return AirDataModel.fromSnapshots(airDataMap: jsonDecode(response.body));
  }
}

