import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:humantiy/screens/nav_bar/bottom_nav_bar.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

class IntroScreen extends StatefulWidget {
  IntroScreen({Key key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = [];

  Function goToTab;

  @override
  void initState() {
    super.initState();
    slides.add(
      Slide(
        title: 'Konum Seçin',
        styleTitle: TextStyle(
            color: Colors.indigo[900],
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
            'Hava kalite bilgisini görmek istediğiniz konumu seçin veya halihazırdaki konumuzu uygulama ile paylaşın.',
        styleDescription: TextStyle(
            color: Colors.indigo[300],
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: 'assets/images/0_50.png',
      ),
    );
    slides.add(
      Slide(
        title: 'Hava Kalitesini Görüntüleyin',
        styleTitle: TextStyle(
            color: Colors.indigo[900],
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
            'Seçtiğiniz konumlardaki hava kalitesi, PM25, PM10 ve CO değerlerini görüntüleyin.',
        styleDescription: TextStyle(
            color: Colors.indigo[300],
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
            pathImage: 'assets/images/51_100.png',
      ),
    );
    slides.add(
      Slide(
        title: 'Haritayı Kullanın',
        styleTitle: TextStyle(
            color: Colors.indigo[900],
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
            'Harita üzerinden yeni konumlar ekleyin veya eklenen konumları görüntüleyin.',
        styleDescription: TextStyle(
            color: Colors.indigo[300],
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: 'assets/images/101_150.png',
      ),
    );
  }

  void onDonePress() {
    saveFirstLogin();
  }

  void onTabChangeCompleted(index) {
    // Index of current tab is focused
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Colors.indigo,
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: Colors.indigo,
    );
  }

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: Colors.indigo,
    );
  }

  List<Widget> renderListCustomTabs() {
    var tabs = <Widget>[];
    for (var i = 0; i < slides.length; i++) {
      var currentSlide = slides[i];
      tabs.add(Container(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          margin: EdgeInsets.only(bottom: 60.0, top: 60.0),
          child: ListView(
            children: <Widget>[
              GestureDetector(
                  child: Image.asset(
                currentSlide.pathImage,
                width: 200.0,
                height: 200.0,
                fit: BoxFit.contain,
              )),
              Container(
                child: Text(
                  currentSlide.title,
                  style: currentSlide.styleTitle,
                  textAlign: TextAlign.center,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
              Container(
                child: Text(
                  currentSlide.description,
                  style: currentSlide.styleDescription,
                  textAlign: TextAlign.center,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
            ],
          ),
        ),
      ));
    }
    return tabs;
  }

  void saveFirstLogin() async{
    var box = await Hive.box('loginState');
    await box.put('loginStatus',1);
     await Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BottomNavBarPage()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      // List slides
      slides: slides,

      // Skip button
      renderSkipBtn: renderSkipBtn(),
      colorSkipBtn: Colors.indigo[100],
      highlightColorSkipBtn: Colors.indigo,

      // Next button
      renderNextBtn: renderNextBtn(),

      // Done button
      renderDoneBtn: renderDoneBtn(),
      onDonePress: onDonePress,
      colorDoneBtn: Colors.indigo[100],
      highlightColorDoneBtn: Colors.indigo,

      // Dot indicator
      colorDot: Colors.indigo,
      sizeDot: 13.0,
      // typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,

      // Tabs
      listCustomTabs: renderListCustomTabs(),
      backgroundColorAllSlides: Colors.white,
      refFuncGoToTab: (refFunc) {
        goToTab = refFunc;
      },

      // Show or hide status bar
      shouldHideStatusBar: true,

      // On tab change completed
      onTabChangeCompleted: onTabChangeCompleted,
    );
  }
}
