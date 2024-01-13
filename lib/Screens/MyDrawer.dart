import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_flutter/widgets/icons.dart';
import 'package:social_media_flutter/widgets/text.dart';

import '../utils/const.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: backgroundDarkBlue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 70.h,),
          GestureDetector(
            onTap: (){

            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              child: Row(
                children: [
                  SizedBox(width: 20.sp,),
                  const Icon(Icons.account_circle_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(width: 20.sp,),
                  Text('Account',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.h,),
          Divider(),
          GestureDetector(
            onTap: (){

            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.sp,vertical: 5.sp),
              child: Row(
                children: [
                  SizedBox(width: 20.sp,),
                  const Icon(Icons.verified_user_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(width: 20.sp,),
                  Text('Privacy Policy',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10.h,),
          GestureDetector(
            onTap: (){

            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.sp,vertical: 5.sp),
              child: Row(
                children: [
                  SizedBox(width: 20.sp,),
                  const Icon(Icons.description_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(width: 20.sp,),
                  Text('Terms & Conditions',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10.h,),
          GestureDetector(
            onTap: (){

            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.sp,vertical: 5.sp),
              child: Row(
                children: [
                  SizedBox(width: 20.sp,),
                  const Icon(Icons.info_outline,
                    color: Colors.white,
                  ),
                  SizedBox(width: 20.sp,),
                  Text('About Us',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10.h,),
          Divider(),
          SizedBox(height: 10.h,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 30.sp),
            child: Text('Follow Us',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 10.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 32,
                width: 32,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Icon(SocialIconsFlutter.instagram,
                  size: 18,
                ),
              ),
              Container(
                height: 32,
                width: 32,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Icon(SocialIconsFlutter.facebook,size: 18,),
              ),
              Container(
                height: 32,
                width: 32,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Icon(SocialIconsFlutter.youtube, size: 18,),
              ),
              Container(
                height: 32,
                width: 32,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Icon(SocialIconsFlutter.linkedin_box,size: 18,),
              ),
            ],
          )


          // Add more list tiles for additional menu items
        ],
      ),
    );
  }
}
