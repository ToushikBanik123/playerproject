import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

import '../api/api.dart';
import '../api/models/ChannelCategory.dart';
import '../api/models/VideoFeedModel.dart'; // Import your model

class PlayerProvider with ChangeNotifier {
  late bool _isFullScreenVideo = false;
  late bool _refreshFlag = false;
  VideoFeedModel? _selectedVideoModel;
  List<LiveTV> _playerPageBottomListTVList = [];
  late int _playerPageBottomListSelectedIndex = 0;
  late VideoPlayerController _miniVideoController;

  get isFullScreenVideo => _isFullScreenVideo;
  get selectedVideoModel => _selectedVideoModel;
  List<LiveTV> get PlayerPageBottomListTVList => _playerPageBottomListTVList;
  get refreshFlag => _refreshFlag;
  get playerPageBottomListSelectedIndex => _playerPageBottomListSelectedIndex;
  VideoPlayerController get miniVideoController => _miniVideoController;

  void setIsFullScreenVideo(bool value) {
    _isFullScreenVideo = value;
    notifyListeners();
  }

  void setRefreshFlag(bool value) {
    _refreshFlag = value;
    notifyListeners();
  }

  void setMiniVideoController(VideoPlayerController value) {
    _miniVideoController = value;
    notifyListeners();
  }
  void disposeMiniVideoController() {
    _miniVideoController.dispose();
    notifyListeners();
  }


  void setPlayerPageBottomListSelectedIndex(int value) {
    _playerPageBottomListSelectedIndex = value;
    notifyListeners();
  }

  //PlayerPageBottomList

  Future<void> fetchAndSortPlayerPageBottomList() async {
    try {
      List<LiveTV> fetchedList = await ApiService().fetchPlayerPageBottomList();
      _playerPageBottomListTVList = fetchedList
        ..sort((a, b) => a.id.compareTo(b.id)); // Sort by id

      print("_playerPageBottomListTVList" + _playerPageBottomListTVList.toString());
      notifyListeners();
    } catch (error) {
      // Handle the error as needed
      print('Error fetching and setting live TV list: $error');
    }
  }

  Future<void> ensurePlayerPageBottomListFilled() async {
    if (_playerPageBottomListTVList.isEmpty) {
      await fetchAndSortPlayerPageBottomList();
    }
  }
}
