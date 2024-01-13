import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../api/models/ChannelCategory.dart';
import 'const.dart';

class TvChannelTile extends StatelessWidget {
  LiveTV liveTV;
  TvChannelTile({Key? key, required this.liveTV}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.sp),
      width: 180.sp,
      height: 101.25.sp,
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(4.r),
        image: liveTV
            .strabgImageGenerator !=
            null
            ? DecorationImage(
          image: NetworkImage(
            liveTV
                .strabgImageGenerator
                .toString(),
          ),
          fit: BoxFit.cover,
        )
            : null, // Set image to null if the URL is null
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 180.sp,
              height: 101.25.sp,
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            // child: Image.network(
            //   liveTV.channelLogo.toString(),
            //   width: (180/2.5).sp,
            //   height: (101.25/2.5).sp,
            //   fit: BoxFit.cover,
            //   errorBuilder: (BuildContext context,
            //       Object error,
            //       StackTrace? stackTrace) {
            //     // Handle the error for Image.network.
            //     return Center(
            //       child: Icon(
            //         Icons.error,
            //         color: Colors.white,
            //         size: 24.sp,
            //       ),
            //     );
            //   },
            // ),
            child: CachedNetworkImage(
              imageUrl: liveTV.channelLogo.toString(),
              width: (180/2.5).sp,
              height: (101.25/2.5).sp,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.white, size: 24.sp),
            ),
          ),
          Positioned(
            top: 10
                .sp, // Adjust the top position as needed
            right: 10
                .sp, // Adjust the right position as needed
            child: Container(
              padding: EdgeInsets.all(3.sp),
              decoration: BoxDecoration(
                color: liveRed,
                borderRadius:
                BorderRadius.circular(5.sp),
              ),
              child: const Center(
                child: Text(
                  'LIVE',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}



class VideoPlayerTvChannelTile extends StatelessWidget {
  LiveTV liveTV;
  VideoPlayerTvChannelTile({Key? key, required this.liveTV}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.sp),
      width: 90.sp,
      height: 50.sp,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(4.r),
        // image: liveTV.strabgImageGenerator != null ? DecorationImage(
        //   image: NetworkImage(
        //     liveTV
        //         .strabgImageGenerator
        //         .toString(),
        //   ),
        //   fit: BoxFit.cover,
        // ) : null,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 180.sp,
              height: 101.25.sp,
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Image.network(
              liveTV.channelLogo.toString(),
              width: (90/2.5).sp,
              height: (50/2.5).sp,
              fit: BoxFit.cover,
              errorBuilder: (BuildContext context,
                  Object error,
                  StackTrace? stackTrace) {
                // Handle the error for Image.network.
                return Center(
                  child: Icon(
                    Icons.error,
                    color: Colors.white,
                    size: 12.sp,
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 0
                .sp, // Adjust the top position as needed
            right: 0
                .sp, // Adjust the right position as needed
            child: Container(
              padding: EdgeInsets.all(3.sp),
              decoration: BoxDecoration(
                color: liveRed,
                borderRadius:
                BorderRadius.circular(0.sp),
              ),
              child: Center(
                child: Text(
                  'LIVE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 5.sp,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
