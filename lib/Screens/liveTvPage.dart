import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../Provider/AppProvider.dart';
import '../Provider/PlayerProvider.dart';
import '../api/api.dart';
import '../api/models/ChannelCategory.dart';
import '../api/models/SliderImage.dart';
import '../utils/TvChannelTile.dart';
import '../utils/VideoLoadingAnimation.dart';
import '../utils/VideoPlayer.dart';
import '../utils/const.dart';

class LiveTvPage extends StatelessWidget {
  ApiService apiService = ApiService();
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<AppProvider>(builder: (context,appProvider,child){
            return Padding(
              padding: EdgeInsets.all(8.sp),
              child: Container(
                width: double.infinity,
                height: 200.0,
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(12.sp),
                  image: (appProvider.sliderImageList != null &&
                      appProvider.sliderImageList.isNotEmpty &&
                      appProvider.sliderImageList[0].coverImage != null)
                      ? DecorationImage(
                    image: NetworkImage(appProvider.sliderImageList[0].coverImage),
                    fit: BoxFit.cover,
                  )
                      : null,
                ),
              ),
            );
          },),

          SizedBox(
            height: 16.h,
          ),
          Consumer<AppProvider>(
            builder: (context, provider, child) {
              // Call the function to fetch data
              // provider.fetchChannelCategoryData();
              provider.refreshChannelCategoryData();

              // Access the data from the provider
              final channelCategoryList = provider.channelCategoryList;

              // Build your UI using the fetched data (assuming catName is a property of ChannelCategory)
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: channelCategoryList.length,
                itemBuilder: (context, index) {
                  final catName = channelCategoryList[index].catName;
                  final List<LiveTV>? liveTVs =
                      channelCategoryList[index].liveTVs;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.sp),
                        child: Text(
                          catName ?? 'Unknown',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            liveTVs!.length,
                            (index) => Consumer<PlayerProvider>(
                                builder: (context, provider, child) {
                              return GestureDetector(
                                onTap: () {
                                  provider.setPlayerPageBottomListSelectedIndex(0);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        //TODO:  videoPlayerPage
                                          builder: (context) => SimpleVideoPlayer(
                                                liveTV: liveTVs[index],
                                              )));
                                },
                                child: TvChannelTile(liveTV: liveTVs[index]),
                              );
                            }),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}



