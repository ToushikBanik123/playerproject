import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../Provider/AppProvider.dart';
import '../Provider/PlayerProvider.dart';
import '../utils/const.dart';
import 'home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundDarkBlue,
        body: Consumer<AppProvider>(builder: (context,appProvider,child){
          appProvider.fetchSliderImageList();
          return Consumer<PlayerProvider>(builder: (context,provider,child){
            provider.fetchAndSortPlayerPageBottomList();
            return Center(
              child: Image(
                image: const AssetImage('assets/images/logoWithBackgroundColor.png'),
                width: 250.sp, // You might need to adjust this to ensure the image covers the circle avatar fully
                height: 250.sp, // You might need to adjust this to ensure the image covers the circle avatar fully
              ),
            );
          },);
        },)
    );
  }
}
