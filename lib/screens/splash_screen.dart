import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hagglextest/screens/login_screen.dart';
import 'package:hagglextest/utility/colors.dart';
import 'package:hagglextest/utility/styles.dart';

class SplashScreen extends StatefulWidget {
  @override
  Splash createState() => Splash();
}

class Splash extends State<SplashScreen> {
  @override
  void initState() {
    startTime();
    super.initState();
  }
  startTime() async {
    var duration = new Duration(seconds: 1);
    return new Timer(duration, route);
  }
  route() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => LoginScreen()));
  }
    @override
  Widget build(BuildContext context) {


    var assetsImage = new AssetImage(
      'assets/logo_white.png',
    ); //<- Creates an object that fetches an image.
    var image = new Image(
        image: assetsImage,
        height: 50); //<- Creates a widget that displays an image.

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image,
            SizedBox(
              height: 20,
            ),
            Text(
              'HaggleX',
              style: AppStyles.onboardinTextStyle
                  .copyWith(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ), //<- place where the image appears
    );
  }
}
