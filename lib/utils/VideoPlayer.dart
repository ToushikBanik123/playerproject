import 'package:colorful_safe_area/colorful_safe_area.dart';import 'package:flutter/material.dart';
import 'package:flutter_in_app_pip/picture_in_picture.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';
import 'package:flutter/services.dart';

import '../Provider/AppProvider.dart';
import '../Provider/PlayerProvider.dart';
import '../Screens/videoPlayerPage.dart';
import '../api/api.dart';
import '../api/models/ChannelCategory.dart';
import '../api/models/VideoFeedModel.dart';
import 'TvChannelTile.dart';
import 'VideoLoadingAnimation.dart';
import 'const.dart';

class SimpleVideoPlayer extends StatefulWidget {
  // final String url;
  final LiveTV liveTV;
  const SimpleVideoPlayer({Key? key, required this.liveTV})
      : super(key: key);

  @override
  _SimpleVideoPlayerState createState() => _SimpleVideoPlayerState();
}

class _SimpleVideoPlayerState extends State<SimpleVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    _toggleHideIcons();
    _controller = VideoPlayerController.network(widget.liveTV.streamUrl)
      ..initialize().then((_) {
        setState(() {});
      })
      ..setLooping(true)
      ..play();
  }
  void _toggleHideIcons() {
    // Reset the visibility after 3 seconds
    Timer(Duration(seconds: 10), () {
      setState(() {
        _isVisible = false;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    PictureInPicture.stopPiP();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      color: backgroundDarkBlue,
      child: Scaffold(
        backgroundColor: backgroundDarkBlue,
        body: OrientationBuilder(
          builder: (context, orientation) {
            return Consumer<PlayerProvider>(builder: (context,provider,child){
              provider.ensurePlayerPageBottomListFilled();
              if (provider.isFullScreenVideo) {
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.landscapeLeft,
                  DeviceOrientation.landscapeRight,
                ]);
              } else {
                SystemChrome
                    .setPreferredOrientations([
                  DeviceOrientation.portraitUp,
                ]);
              }
              return (!provider.isFullScreenVideo) ? SingleChildScrollView(
                child: Column(
                  children: [
                    AspectRatio(
                      // aspectRatio: _controller.value.aspectRatio,
                      aspectRatio: 16/9,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isVisible = !_isVisible;
                            if (_controller.value.isPlaying) {
                              _toggleHideIcons();
                            } else {
                              // _controller.play();
                            }
                          });
                        },
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          fit: StackFit.loose,
                          children: <Widget>[
                            _controller.value.isInitialized ? VideoPlayer(_controller) : VideoLoadingAnimation(),
                            _isVisible
                                ? Align(
                              alignment: Alignment.center,
                              child: Container(
                                height:
                                (orientation == Orientation.portrait)
                                    ? 250.sp
                                    : double.infinity,
                                width: (orientation == Orientation.portrait)
                                    ? double.infinity
                                    : double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.black38,
                                ),
                              ),
                            )
                                : Container(),
                            VideoProgressIndicator(_controller, allowScrubbing: false),

                            //Back Button
                            Positioned(
                              top: 15.sp,
                              left: 10.sp,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: _isVisible
                                    ? Icon(
                                  Icons.arrow_back_ios_new,
                                  size: 20.0,
                                  color: Colors.white,
                                )
                                    : Container(),
                              ),
                            ),

                            Align(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (_controller.value.isPlaying) {
                                      _controller.pause();
                                    } else {
                                      _controller.play();
                                    }
                                  });
                                },
                                child: _isVisible
                                    ? Icon(
                                  _controller.value.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  size: 50.0,
                                  color: Colors.white,
                                )
                                    : Container(),
                              ),
                            ),
                            //Go back chanel
                            Align(
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                onTap: () {
                                  if(0 < provider.playerPageBottomListSelectedIndex){
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          //TODO:  videoPlayerPage
                                            builder: (context) => SimpleVideoPlayer(
                                              liveTV: provider.PlayerPageBottomListTVList[provider.playerPageBottomListSelectedIndex],
                                            )));
                                    provider.setPlayerPageBottomListSelectedIndex(provider.playerPageBottomListSelectedIndex-1);
                                  }

                                },
                                child: _isVisible
                                    ? const Icon(
                                  Icons.arrow_left,
                                  size: 50.0,
                                  color: Colors.white,
                                )
                                    : Container(),
                              ),
                            ),
                            //Go next chanel
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  if(provider.playerPageBottomListSelectedIndex < provider.PlayerPageBottomListTVList.length){
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          //TODO:  videoPlayerPage
                                            builder: (context) => SimpleVideoPlayer(
                                              liveTV: provider.PlayerPageBottomListTVList[provider.playerPageBottomListSelectedIndex],
                                            )));
                                    provider.setPlayerPageBottomListSelectedIndex(provider.playerPageBottomListSelectedIndex+1);
                                  }

                                },
                                child: _isVisible
                                    ? Icon(
                                  Icons.arrow_right,
                                  size: 50.0,
                                  color: Colors.white,
                                )
                                    : Container(),
                              ),
                            ),

                            Align(
                              alignment: Alignment.bottomRight,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {},
                                        child: _isVisible
                                            ? Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Icon(
                                            Icons.settings_outlined,
                                            size: 25,
                                            color: Colors.white,
                                          ),
                                        )
                                            : Container(),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          PictureInPicture.startPiP(
                                            pipWidget: _buildPiPContent(context),
                                          );
                                        },
                                        child: _isVisible
                                            ? Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Icon(
                                            Icons.picture_in_picture_alt_sharp,
                                            size: 25,
                                            color: Colors.white,
                                          ),
                                        )
                                            : Container(),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (provider.isFullScreenVideo) {
                                            provider.setIsFullScreenVideo(false);
                                          } else {
                                            provider.setIsFullScreenVideo(true);
                                          }
                                        },
                                        child: _isVisible
                                            ? Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Icon(
                                            provider.isFullScreenVideo? Icons.close_fullscreen : Icons.open_in_full,
                                            size: 25,
                                            color: Colors.white,
                                          ),
                                        )
                                            : Container(),
                                      ),

                                      SizedBox(
                                        width: 20.sp,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2.sp,
                                  ),
                                  (_isVisible && provider.isFullScreenVideo)? SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: List.generate(
                                        provider.PlayerPageBottomListTVList!.length,
                                            (index) => GestureDetector(
                                          onTap: () {
                                            Navigator.pushReplacement(
                                              context,
                                              //TODO:  videoPlayerPage
                                              MaterialPageRoute(builder: (context) => SimpleVideoPlayer(liveTV: provider.PlayerPageBottomListTVList[index],)),
                                            );
                                          },
                                          child: VideoPlayerTvChannelTile(liveTV: provider.PlayerPageBottomListTVList[index]),
                                        ),
                                      ),
                                    ),
                                  ) : const SizedBox(),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // SizedBox(
                                  //   height: 10.sp,
                                  // )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 35.sp,
                                width: 35.sp,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: widget.liveTV.channelLogo !=
                                      null
                                      ? DecorationImage(
                                    image: NetworkImage(
                                      widget.liveTV.channelLogo.toString(),
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                      : null, // Set image to null if the URL is null
                                ),
                              ),
                              SizedBox(width: 10.sp,),
                              Text(widget.liveTV.channelName.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: (){
                              //TODO: Do the Shear thing
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/share_icon.png',
                                  width: 22.sp,
                                  height: 22.sp,
                                ),
                                SizedBox(height: 2.sp,),
                                Text("Share",
                                  style:  TextStyle(
                                    color: Colors.white,
                                    fontSize: 11.sp,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Divider(
                      color: Colors.white,
                      height: 5.sp,
                    ),
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
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
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
                                  height: 30.h,
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ) : SizedBox(
                // height: (!provider.isFullScreenVideo) ? 250.sp : double.infinity,
                // width: (orientation == Orientation.portrait) ? double.infinity : double.infinity,
                child: Center(
                  child: AspectRatio(
                    // aspectRatio: _controller.value.aspectRatio,
                    aspectRatio: 16/9,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isVisible = !_isVisible;
                          if (_controller.value.isPlaying) {
                            _toggleHideIcons();
                          } else {
                            // _controller.play();
                          }
                        });
                      },
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        fit: StackFit.loose,
                        children: <Widget>[
                          _controller.value.isInitialized ? VideoPlayer(_controller) : VideoLoadingAnimation(),
                          _isVisible
                              ? Align(
                            alignment: Alignment.center,
                            child: Container(
                              height:
                              (orientation == Orientation.portrait)
                                  ? 250.sp
                                  : double.infinity,
                              width: (orientation == Orientation.portrait)
                                  ? double.infinity
                                  : double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.black38,
                              ),
                            ),
                          )
                              : Container(),
                          VideoProgressIndicator(_controller, allowScrubbing: false),

                          //Back Button
                          Positioned(
                            top: 15.sp,
                            left: 10.sp,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: _isVisible
                                  ? Icon(
                                Icons.arrow_back_ios_new,
                                size: 20.0,
                                color: Colors.white,
                              )
                                  : Container(),
                            ),
                          ),

                          Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (_controller.value.isPlaying) {
                                    _controller.pause();
                                  } else {
                                    _controller.play();
                                  }
                                });
                              },
                              child: _isVisible
                                  ? Icon(
                                _controller.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                size: 50.0,
                                color: Colors.white,
                              )
                                  : Container(),
                            ),
                          ),
                          //Go back chanel
                          Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () {
                                if(0 < provider.playerPageBottomListSelectedIndex){
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        //TODO:  videoPlayerPage
                                          builder: (context) => SimpleVideoPlayer(
                                            liveTV: provider.PlayerPageBottomListTVList[provider.playerPageBottomListSelectedIndex],
                                          )));
                                  provider.setPlayerPageBottomListSelectedIndex(provider.playerPageBottomListSelectedIndex-1);
                                }

                              },
                              child: _isVisible
                                  ? const Icon(
                                Icons.arrow_left,
                                size: 50.0,
                                color: Colors.white,
                              )
                                  : Container(),
                            ),
                          ),
                          //Go next chanel
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                if(provider.playerPageBottomListSelectedIndex < provider.PlayerPageBottomListTVList.length){
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        //TODO:  videoPlayerPage
                                          builder: (context) => SimpleVideoPlayer(
                                            liveTV: provider.PlayerPageBottomListTVList[provider.playerPageBottomListSelectedIndex],
                                          )));
                                  provider.setPlayerPageBottomListSelectedIndex(provider.playerPageBottomListSelectedIndex+1);
                                }

                              },
                              child: _isVisible
                                  ? Icon(
                                Icons.arrow_right,
                                size: 50.0,
                                color: Colors.white,
                              )
                                  : Container(),
                            ),
                          ),

                          Align(
                            alignment: Alignment.bottomRight,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: _isVisible
                                          ? Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Icon(
                                          Icons.settings_outlined,
                                          size: 25,
                                          color: Colors.white,
                                        ),
                                      )
                                          : Container(),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        PictureInPicture.startPiP(
                                          pipWidget: _buildPiPContent(context),
                                        );
                                      },
                                      child: _isVisible
                                          ? const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Icon(
                                          Icons.picture_in_picture_alt_sharp,
                                          size: 25,
                                          color: Colors.white,
                                        ),
                                      )
                                          : Container(),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (provider.isFullScreenVideo) {
                                          provider.setIsFullScreenVideo(false);
                                        } else {
                                          provider.setIsFullScreenVideo(true);
                                        }
                                      },
                                      child: _isVisible
                                          ? Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Icon(
                                          provider.isFullScreenVideo? Icons.close_fullscreen : Icons.open_in_full,
                                          size: 25,
                                          color: Colors.white,
                                        ),
                                      )
                                          : Container(),
                                    ),

                                    SizedBox(
                                      width: 20.sp,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 2.sp,
                                ),
                                (_isVisible && provider.isFullScreenVideo)? SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: List.generate(
                                      provider.PlayerPageBottomListTVList!.length,
                                          (index) => GestureDetector(
                                        onTap: () {
                                          Navigator.pushReplacement(
                                            context,
                                            //TODO:  videoPlayerPage
                                            MaterialPageRoute(builder: (context) => SimpleVideoPlayer(liveTV: provider.PlayerPageBottomListTVList[index],)),
                                          );
                                        },
                                        child: VideoPlayerTvChannelTile(liveTV: provider.PlayerPageBottomListTVList[index]),
                                      ),
                                    ),
                                  ),
                                ) : const SizedBox(),
                                SizedBox(
                                  height: 10,
                                ),
                                // SizedBox(
                                //   height: 10.sp,
                                // )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            });
          },
        ),
      ),
    );

  }



  Widget _buildPiPContent(BuildContext context) {
    return Consumer<AppProvider>(builder: (context,provider,child){
      return Stack(
        children: [
          _controller.value.isInitialized ? VideoPlayer(_controller) : VideoLoadingAnimation(),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                PictureInPicture.stopPiP();
              },
              child:  Container(
                height: 25.sp,
                width: 25.sp,
                color: Colors.black,
                alignment: Alignment.center,
                child: Icon(
                  Icons.close,
                  size: 20.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
