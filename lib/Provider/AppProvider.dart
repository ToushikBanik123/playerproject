import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../api/api.dart';
import '../api/models/ChannelCategory.dart';
import '../api/models/SliderImage.dart';
import '../api/models/VideoFeedModel.dart'; // Import your model

class AppProvider with ChangeNotifier {
  late int _selectedVideoId = 0;

  // late VideoFeedModel _selectedVideoModel;
  VideoFeedModel? _selectedVideoModel;


  // List to store ChannelCategory data
  List<ChannelCategory> _channelCategoryList = [];
  List<SliderImage> _sliderImageList = [];

  get selectedVideoId => _selectedVideoId;

  get selectedVideoModel => _selectedVideoModel;

  get sliderImageList => _sliderImageList;


  // Getter for channelCategoryList
  List<ChannelCategory> get channelCategoryList => _channelCategoryList;

  void setSelectedVideoId(int value) {
    _selectedVideoId = value;
    fetchVideoData();
    notifyListeners();
  }


  // Function to check if the list is empty and fetch data if needed
  Future<void> fetchChannelCategoryData() async {
    if (_channelCategoryList.isEmpty) {
      try {
        // Create an instance of ApiService
        final apiService = ApiService();

        // Fetch ChannelCategory data from the API
        final catChannelList = await apiService.fetchCatChannelList();

        // Update the channelCategoryList and notify listeners
        _channelCategoryList = catChannelList;
        notifyListeners();
      } catch (e) {
        // Handle the exception, e.g., show an error message
        print('Error fetching data: $e');
      }
    }
  }

  int maxRecursionDepth = 5; // Set an arbitrary limit
  int currentRecursionDepth = 0;

  Future<void> refreshChannelCategoryData() async {
    try {
      // Create an instance of ApiService
      final apiService = ApiService();

      // Fetch fresh ChannelCategory data from the API
      final catChannelList = await apiService.fetchCatChannelList();

      // Update the channelCategoryList and notify listeners
      _channelCategoryList = catChannelList;

      if (_channelCategoryList.isEmpty &&
          currentRecursionDepth < maxRecursionDepth) {
        currentRecursionDepth++;
        await refreshChannelCategoryData();
        currentRecursionDepth--;
      }

      notifyListeners();
    } catch (e) {
      // Handle the exception, e.g., show an error message
      print('Error refreshing data: $e');
    }
  }

  Future<void> fetchVideoData() async {
    try {
      // Create an instance of ApiService
      final apiService = ApiService();
      _selectedVideoModel =
      await apiService.videoFeedCallingFunction(_selectedVideoId);
      notifyListeners();
    } catch (e) {
      // Handle the exception, e.g., show an error message
      print('Error refreshing data: $e');
    }
  }

  Future<void> fetchSliderImageList() async {
    try {
      // Create an instance of ApiService
      final apiService = ApiService();
      _sliderImageList = await apiService.fetchSliderImages();
      notifyListeners();
    } catch (e) {
      // Handle the exception, e.g., show an error message
      print('Error refreshing data: $e');
    }
  }




}