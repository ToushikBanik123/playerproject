// import 'package:colorful_safe_area/colorful_safe_area.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_in_app_pip/picture_in_picture.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:jbottapp/Provider/AppProvider.dart';
// import 'package:jbottapp/api/api.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';
//
// import '../Provider/PlayerProvider.dart';
// import '../Provider/PlayerProvider.dart';
// import '../api/models/ChannelCategory.dart';
// import '../api/models/VideoFeedModel.dart';
// import '../utils/TvChannelTile.dart';
// import '../utils/VideoLoadingAnimation.dart';
// import '../utils/VideoPlayer.dart';
// import '../utils/const.dart';
// import 'package:flutter/services.dart';
//
//
//
// class videoPlayerPage extends StatefulWidget {
//    videoPlayerPage({required this.liveTV, Key? key}) : super(key: key);
//    final LiveTV liveTV;
//
//   @override
//   State<videoPlayerPage> createState() => _videoPlayerPageState();
// }
//
// class _videoPlayerPageState extends State<videoPlayerPage> {
//   ApiService apiService = ApiService();
//   late Future<VideoFeedModel> _videoFeedFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     _videoFeedFuture = apiService.videoFeedCallingFunction(widget.liveTV.id);
//   }
//
//   Future<void> _refresh() async {
//     setState(() {
//       _videoFeedFuture = apiService.videoFeedCallingFunction(widget.liveTV.id);
//     });
//   }
//
//
//   void startRefreshLoop() async {
//     while (Provider.of<PlayerProvider>(context, listen: false).refreshFlag) {
//       await _refresh();
//       await Future.delayed(Duration(seconds: 5));
//     }
//   }
//
//
//   @override
//   void dispose() {
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//       DeviceOrientation.landscapeLeft,
//       DeviceOrientation.landscapeRight,
//     ]);
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ColorfulSafeArea(
//       color: backgroundDarkBlue,
//       child: Scaffold(
//         backgroundColor: backgroundDarkBlue,
//         body: OrientationBuilder(
//           builder: (context,orientation){
//             return Consumer<PlayerProvider>(builder: (context,provider,child){
//               if (provider.isFullScreenVideo) {
//                 SystemChrome
//                     .setPreferredOrientations([
//                   DeviceOrientation.landscapeLeft,
//                   DeviceOrientation.landscapeRight,
//                 ]);
//               } else {
//                 SystemChrome
//                     .setPreferredOrientations([
//                   DeviceOrientation.portraitUp,
//                 ]);
//               }
//               return provider.isFullScreenVideo ?
//               (widget.liveTV.streamUrl != null) ? SimpleVideoPlayer(
//                 url: widget.liveTV.streamUrl.toString(),
//               ) : VideoLoadingAnimation()
//                   :
//               SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     // FutureBuilder<VideoFeedModel>(
//                     //   // future: apiService.videoFeedCallingFunction(widget.liveTV.id),
//                     //   future: _videoFeedFuture,
//                     //   builder: (context, snapshot) {
//                     //     if (snapshot.connectionState == ConnectionState.waiting) {
//                     //       return VideoLoadingAnimation();
//                     //     }
//                     //     else if (!snapshot.hasData || snapshot.data == null) {
//                     //       //turning on the auto Refresh
//                     //       provider.setRefreshFlag(true);
//                     //       startRefreshLoop();
//                     //       return Column(
//                     //         crossAxisAlignment: CrossAxisAlignment.center,
//                     //         children: [
//                     //           VideoLoadingAnimation(),
//                     //           Text('No data available in id: ${widget.liveTV.id}',
//                     //             style: TextStyle(
//                     //               color: Colors.white,
//                     //             ),
//                     //           ),
//                     //           ElevatedButton(
//                     //             onPressed: (){
//                     //               _refresh();
//                     //               startRefreshLoop();
//                     //             },
//                     //             child: Text('Refresh'),
//                     //           ),
//                     //         ],
//                     //       );
//                     //     }
//                     //     else {
//                     //       VideoFeedModel videoFeed = snapshot.data!;
//                     //       //Turning of the auto refresh
//                     //       provider.setRefreshFlag(false);
//                     //       // Print or log the stream URL for debugging
//                     //       print("Stream URL: ${videoFeed.streamUrl}");
//                     //       return Container(
//                     //         width: double.infinity,
//                     //         height: provider.isFullScreenVideo ? double.infinity : 200.h,
//                     //         decoration: BoxDecoration(
//                     //           color: Colors.black,
//                     //           borderRadius: BorderRadius.circular(12.sp),
//                     //         ),
//                     //         child: SimpleVideoPlayer(
//                     //           url: videoFeed.streamUrl.toString(),
//                     //         ),
//                     //       );
//                     //     }
//                     //   },
//                     // ),
//
//                     (widget.liveTV.streamUrl != null) ? SimpleVideoPlayer(
//                       url: widget.liveTV.streamUrl.toString(),
//                     ) : VideoLoadingAnimation(),
//
//                     SizedBox(
//                       height: 12.h,
//                     ),
//                      Container(
//                       margin: EdgeInsets.symmetric(horizontal: 8.sp),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             children: [
//                               Container(
//                                 height: 35.sp,
//                                 width: 35.sp,
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   image: widget.liveTV.channelLogo !=
//                                       null
//                                       ? DecorationImage(
//                                     image: NetworkImage(
//                                       widget.liveTV.channelLogo.toString(),
//                                     ),
//                                     fit: BoxFit.cover,
//                                   )
//                                       : null, // Set image to null if the URL is null
//                                 ),
//                               ),
//                               SizedBox(width: 10.sp,),
//                               Text(widget.liveTV.channelName.toString(),
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           GestureDetector(
//                             onTap: (){
//                               //TODO: Do the Shear thing
//                             },
//                             child: Column(
//                               children: [
//                                 Image.asset(
//                                   'assets/images/share_icon.png',
//                                   width: 22.sp,
//                                   height: 22.sp,
//                                 ),
//                                 SizedBox(height: 2.sp,),
//                                 Text("Share",
//                                   style:  TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 11.sp,
//                                   ),
//                                 )
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 12.h,
//                     ),
//                     Divider(
//                       color: Colors.white,
//                       height: 5.sp,
//                     ),
//                     SizedBox(
//                       height: 16.h,
//                     ),
//                     Consumer<AppProvider>(
//                       builder: (context, provider, child) {
//                         // Call the function to fetch data
//                         // provider.fetchChannelCategoryData();
//                         provider.refreshChannelCategoryData();
//
//                         // Access the data from the provider
//                         final channelCategoryList = provider.channelCategoryList;
//
//                         // Build your UI using the fetched data (assuming catName is a property of ChannelCategory)
//                         return ListView.builder(
//                           shrinkWrap: true,
//                           physics: NeverScrollableScrollPhysics(),
//                           itemCount: channelCategoryList.length,
//                           itemBuilder: (context, index) {
//                             final catName = channelCategoryList[index].catName;
//                             final List<LiveTV>? liveTVs =
//                                 channelCategoryList[index].liveTVs;
//
//                             return Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsets.symmetric(horizontal: 8.sp),
//                                   child: Text(
//                                     catName ?? 'Unknown',
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 6.h,
//                                 ),
//                                 SingleChildScrollView(
//                                   scrollDirection: Axis.horizontal,
//                                   child: Row(
//                                     children: List.generate(
//                                       liveTVs!.length,
//                                           (index) => Consumer<PlayerProvider>(
//                                           builder: (context, provider, child) {
//                                             return GestureDetector(
//                                               onTap: () {
//                                                 provider.setPlayerPageBottomListSelectedIndex(0);
//                                                 Navigator.pushReplacement(
//                                                     context,
//                                                     MaterialPageRoute(
//                                                         builder: (context) => videoPlayerPage(
//                                                           liveTV: liveTVs[index],
//                                                         )));
//                                               },
//                                               child: TvChannelTile(liveTV: liveTVs[index]),
//                                             );
//                                           }),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 30.h,
//                                 ),
//                               ],
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               );
//             });
//           },
//         ),
//       ),
//     );
//   }
// }
//
