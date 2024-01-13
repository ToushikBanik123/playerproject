import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../Provider/PlayerProvider.dart';

class VideoLoadingAnimation extends StatelessWidget {
  const VideoLoadingAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerProvider>(builder: (context,provider,child){
      return Container(
        width: double.infinity,
        height: double.infinity,
        // height: provider.isFullScreenVideo? double.infinity : 250.h,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12.sp),
        ),
        child: SizedBox(
          height: 50,
          width: 50,
          child: Lottie.asset(
            'assets/images/videoLoading.json',
            width: 200,
            height: 200,
            fit: BoxFit.fill,
          ),
        ),
      );
    });
  }
}
