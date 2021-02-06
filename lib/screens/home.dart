import 'package:flutter/material.dart';
import 'package:humantiy/constants.dart';
import 'package:humantiy/core/locator.dart';
import 'package:humantiy/core/services/data_services.dart';
import 'package:humantiy/core/services/location_services.dart';
import 'package:humantiy/models/air_data_model.dart';

import '../core/locator.dart';

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

  test2() async {
    var model2 = getIt<DataServicesBaraj>();
    BarajDataModel tester2 = await model2.getBarajData();
    print('isim: ${tester2.isim}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: test2,
      ),
    );
  }
}
