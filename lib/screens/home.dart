import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hive/hive.dart';
import 'package:humantiy/constants.dart';
import 'package:humantiy/core/locator.dart';
import 'package:humantiy/core/services/data_services.dart';
import 'package:humantiy/core/services/location_services.dart';
import 'package:shimmer/shimmer.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  CarouselController buttonCarouselController = CarouselController();
  List<Widget> imageSliders = [];
  final double _radius = 16;
  List<String> locationDataContent = ['null', 'null', 'null', 'null', 'null'];
  bool isLoading = false;
  var current = 0;
  final List<String> locationDataTitles = [
    'Hava Kalitesi:',
    'Karbonmonoksit:',
    'Pm25:',
    'Pm10:',
    'Son Güncellenme Tarihi:'
  ];
  List<dynamic> myLocationsData = [];

  // void test() async{
  //   var model = getIt<DataServicesFromCoordinate>(param1: '41', param2: '29',);
  //   final tester = await model.getCityDataFromCoordinate();
  //   print(tester.lat);
  // }

  void sliderIndexChange(var index) async {
    if (mounted) {
      setState(() {
        current = index;
        isLoading = true;
      });
    }
    var coordinateLocationModel = getIt<DataServicesFromCoordinate>(
      param1: myLocationsData[index][0].toString(),
      param2: myLocationsData[index][1].toString(),
    );
    final airDataModel =
        await coordinateLocationModel.getCityDataFromCoordinate();
    if (mounted) {
      setState(() {
        isLoading = false;
        locationDataContent.insert(0, airDataModel.aqi.toString());
        locationDataContent.insert(1, airDataModel.co.toString());
        locationDataContent.insert(2, airDataModel.pm25.toString());
        locationDataContent.insert(3, airDataModel.pm10.toString());
        locationDataContent.insert(4, airDataModel.time.toString());
      });
    }
  }

  Widget locationSlider(Size size) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: myLocationsData.length,
          itemBuilder: (BuildContext context, int index, int num) {
            return Container(
              child: InkWell(
                onTap: () => {},
                child: Container(
                  margin: EdgeInsets.all(2),
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      child: Stack(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              color: Colors.white,
                              height: size.height * 0.5, // 180
                              child: Image.network(
                                'https://i.ytimg.com/vi/hUxV79NZ0fs/maxresdefault.jpg',
                                width: size.width * 0.9,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0.0,
                            left: 0.0,
                            right: 0.0,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(200, 0, 0, 0),
                                    Color.fromARGB(0, 0, 0, 0)
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              child: Text(
                                myLocationsData[index][2],
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ],
                      )),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black.withOpacity(0.1), width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            );
          },
          options: CarouselOptions(
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            aspectRatio: 2.0,
            onPageChanged: (index, reason) => sliderIndexChange(index),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: myLocationsData.map((url) {
            final index = myLocationsData.indexOf(url);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: current == index
                    ? Colors.grey
                    : Colors.grey.withOpacity(0.6),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget locationDetailsInfo(Size size) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_radius),
      ),
      child: Container(
          width: size.width * 0.9,
          padding: EdgeInsets.all(8.0),
          child: AnimatedCrossFade(
            firstChild: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: locationDataTitles.length,
              itemBuilder: (context, index) {
                return Offstage(
                  offstage: locationDataContent[index] == 'null',
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          locationDataTitles[index],
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          locationDataContent[index],
                          style: TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            secondChild: Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: Colors.grey.withOpacity(.6),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: locationDataTitles.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Container(
                      alignment: Alignment.center,
                      width: size.width * .7,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.3),
                        borderRadius: BorderRadius.circular(_radius),
                      ),
                    ),
                  );
                },
              ),
            ),
            duration: Duration(milliseconds: 200),
            crossFadeState: isLoading || locationDataContent[3] == 'null'
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
          )),
    );
  }

  Widget showLoading(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: SimpleDialog(
              backgroundColor: Colors.transparent,
              children: <Widget>[
                Center(
                  child: Container(
                    child: Column(children: [
                      CircularProgressIndicator(),
                    ]),
                  ),
                )
              ]),
        ));
  }

  void checkCurrentLocation() async {
    await Hive.openBox('myLocationsDb');
    var box = await Hive.box('myLocationsDb');
    if(box.get('savedAreas') == null){
      var locationServices = getIt<LocationServices>();
    final position = await locationServices.getPosition();

    var coordinateLocationModel = getIt<DataServicesFromCoordinate>(
      param1: position.latitude.toString(),
      param2: position.longitude.toString(),
    );
    final airDataModel =
        await coordinateLocationModel.getCityDataFromCoordinate();
    List<dynamic> tempAreas = await box.get('savedAreas') ?? [];
    tempAreas.isNotEmpty ? tempAreas.removeAt(0) : null;
    tempAreas
        .insert(0, [position.latitude, position.longitude, airDataModel.name]);
    await box.put('savedAreas', tempAreas);
    }
    if (mounted) {
      setState(() {
        isGetCurrentLocation = true;
      });
    }
  }

  void loadDefaults() async {
    await checkCurrentLocation();
    await Hive.openBox('myLocationsDb');
    var box = await Hive.box('myLocationsDb');
    var getSavedAreas = await box.get('savedAreas');
    print(getSavedAreas);
    if (mounted) {
      setState(() {
        myLocationsData = getSavedAreas;
      });
    }
    await sliderIndexChange(0);
  }

  @override
  void initState() {
    loadDefaults();
    super.initState();
  }

  void deleteFromHive() async {
    await Hive.openBox('myLocationsDb');
    var box = await Hive.box('myLocationsDb');
    var getSavedAreas = await box.get('savedAreas');
    getSavedAreas.removeAt(current);
    Navigator.pop(context);
    loadDefaults();
  }

  void showDeleteCheck(String locationName) {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
                '$locationName adlı bölgeyi listenizden kaldırmak istediğinize emin misiniz?'),
            actions: [
              TextButton(
                  onPressed: () {
                    deleteFromHive();
                  },
                  child: Text('Kaldır')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Vazgeç',
                    style: TextStyle(color: Colors.grey[700]),
                  )),
            ],
          );
        });
  }

  void setChanges() {
    if (isSavedNewArea) {
      if (mounted) {
        setState(() {
          isSavedNewArea = false;
          loadDefaults();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    setChanges();
    return isGetCurrentLocation
        ? SingleChildScrollView(
          child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: locationSlider(size),
                ),
                locationDetailsInfo(size),
                Offstage(
                  offstage: current == 0,
                  child: Center(
                    child: TextButton(
                      child: Text('Kaldır'),
                      onPressed: () =>
                          showDeleteCheck(myLocationsData[current][2]),
                    ),
                  ),
                )
              ],
            ),
        )
        : showLoading(context);
  }
}
