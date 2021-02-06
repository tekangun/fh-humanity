import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:humantiy/constants.dart';
import 'package:humantiy/core/locator.dart';
import 'package:humantiy/core/services/data_services.dart';
import 'package:humantiy/models/air_data_model.dart';
import 'package:shimmer/shimmer.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  CarouselController buttonCarouselController = CarouselController();
  List<Widget> imageSliders = [];
  final double _radius = 16;
  List<String> locationDataContent = ['null', 'null', 'null', 'null'];
  bool isLoading = false;
  var current = 0;
  final List<String> locationDataTitles = [
    'Karbondioksit:',
    'Pm25:',
    'Pm10:',
    'Son Güncellenme Tarihi:'
  ];
  List<dynamic> myLocationsData = [];

  final List<dynamic> myDefaultLocationsData = [
    ['41', '29', 'Catladikapi, Turkey'],
  ];

  // void test() async{
  //   var model = getIt<DataServicesFromCoordinate>(param1: '41', param2: '29',);
  //   final tester = await model.getCityDataFromCoordinate();
  //   print(tester.lat);
  // }

  void sliderIndexChange(var index) async {
    if (mounted) {
      setState(() {
        isLoading = true;
        current = index;
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
        locationDataContent.insert(0, airDataModel.co.toString());
        locationDataContent.insert(1, airDataModel.pm25.toString());
        locationDataContent.insert(2, airDataModel.pm10.toString());
        locationDataContent.insert(3, airDataModel.time.toString());
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



  void loadDefaults() async {
    await Hive.openBox('myLocationsDb');
    var box = await Hive.box('myLocationsDb');
    var getSavedAreas = await box.get('savedAreas');
    print(getSavedAreas);
    if (mounted) {
      setState(() {
        getSavedAreas == null ? isDefaultAreaData = true : isDefaultAreaData = false;
        myLocationsData = getSavedAreas ?? myDefaultLocationsData;
      });
    }
    await sliderIndexChange(0);
  }

  @override
  void initState() {
    loadDefaults();
    super.initState();
  }

  void deleteFromHive() async{
    await Hive.openBox('myLocationsDb');
    var box = await Hive.box('myLocationsDb');
    var getSavedAreas = await box.get('savedAreas');
    getSavedAreas.removeAt(current);
    if(getSavedAreas.isEmpty){
      if(mounted){
        setState(() {
          getSavedAreas = myDefaultLocationsData;
          isDefaultAreaData = true;
        });
      }
    }
    await box.delete('savedAreas');
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

  setChanges(){
    if(isSavedNewArea){
      if(mounted){
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
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: locationSlider(size),
        ),
        locationDetailsInfo(size),
        Offstage(
          offstage: isDefaultAreaData,
          child: Center(
          child: TextButton(
            child: Text('Kaldır'),
            onPressed: () => showDeleteCheck(myLocationsData[current][2]),
          ),
        ),
        )
      ],
    );
  }
}
