class AirDataModel {
  var co;
  var pm25;
  var pm10;

  AirDataModel({
    this.co,
    this.pm25,
    this.pm10,
  });

  factory AirDataModel.fromSnapshots({Map<String, dynamic> airDataMap}) {
    return AirDataModel(
      co: airDataMap['data']['iaqi']['co'] != null
          ? airDataMap['data']['iaqi']['co']['v']
          : null,
      pm25: airDataMap['data']['iaqi']['pm25'] != null
          ? airDataMap['data']['iaqi']['pm25']['v']
          : null,
      pm10: airDataMap['data']['iaqi']['pm10'] != null
          ? airDataMap['data']['iaqi']['pm10']['v']
          : null,
    );
  }
}

class BarajDataModel {
  var isim;
  var deneme;
  BarajDataModel({this.isim, this.deneme});
  factory BarajDataModel.fromSnapshots({Map<String, dynamic> barajDataMap}) {
    print(barajDataMap);

    return BarajDataModel(
      isim: barajDataMap['data'],
      deneme: barajDataMap['data']['help'],
    );
  }
}
