import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive/hive.dart';
import 'package:humantiy/screens/intro.dart';
import 'package:humantiy/screens/nav_bar/bottom_nav_bar.dart';




class SplashPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage>{




  Future welcomeScreen() async{
    await Hive.openBox('loginState');
    var box = await Hive.box('loginState');
    var status = await box.get('loginStatus');
    Timer(Duration(seconds: 3), () {
      if(status == 1){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BottomNavBarPage()), (route) => false);
      }
      else {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => IntroScreen()), (route) => false);
      }
    });
  }


  @override
  void initState() {
    welcomeScreen();
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/0_50.png',
                    width: size.width * 0.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        width: size.width,
        height: 40,
        color: Colors.white,
        child: Text('Humantiy',style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.center,),
      ),
    );
  }


}