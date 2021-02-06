class AirDataModel {
  var co;
  var pm25;
  var pm10;
  var name;
  var lat;
  var lng;
  var time;

  AirDataModel({
    this.co,
    this.pm25,
    this.pm10,
    this.name,
    this.lat,
    this.lng,
    this.time,
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
       name: airDataMap['data']['city']['name'],
       lat: airDataMap['data']['city']['geo'][0],
       lng: airDataMap['data']['city']['geo'][1],
       time: airDataMap['data']['time']['s'],
    );
  }
}
