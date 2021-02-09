import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomLottieWidget extends StatelessWidget {
  final String path;
  const CustomLottieWidget({Key key, @required this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Lottie.asset('assets/lottie/$path.json', repeat: true);
  }
}
