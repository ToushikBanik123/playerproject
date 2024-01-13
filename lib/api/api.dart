import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/const.dart';
import 'models/ChannelCategory.dart';
import 'models/SliderImage.dart';
import 'models/VideoFeedModel.dart';

class ApiService {

  Future<String> getToken() async {
    final tokenUrl = getTokenApi;

    try {
      final response = await http.get(Uri.parse(tokenUrl));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        String token = data['s'];
        return token;
      } else {
        throw Exception('Failed to fetch token');
      }
    } catch (e) {
      throw Exception('Error fetching token: $e');
    }
  }

  Future<List<ChannelCategory>> fetchCatChannelList() async {
    try {
      final token = await getToken();
      // final catChannelApi = '$baseUrl/liveCategoryApi';

      final response = await http.get(
        Uri.parse(liveCategoryApi),
        headers: {
          'a': 'f $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<ChannelCategory> catChannels = data.map((json) => ChannelCategory.fromJson(json)).toList();
        return catChannels;
      } else {
        throw Exception('Failed to fetch Cat and Channel List: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching Cat and Channel List: $e');
    }
  }

  Future<VideoFeedModel> videoFeedCallingFunction(int channelId) async {
    try {
      final token = await getToken();
      final apiUrl = 'http://apjgsecure.jgo.tv/livetv/$channelId';

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'a': 'f $token',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        print("___Data : " + data.toString());
        return VideoFeedModel.fromJson(data);
      } else {
        throw Exception('Failed to fetch video feed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching video feed: $e');
    }
  }

  //PlayerPageBottomList
  Future<List<LiveTV>> fetchPlayerPageBottomList() async {
    try {
      final token = await getToken();
      final apiUrl = 'http://apjgsecure.jgo.tv/api/V1/live-tv/';

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'a': 'f $token',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<LiveTV> liveTVList = data.map((tv) => LiveTV.fromJson(tv)).toList();
        return liveTVList;
      } else {
        throw Exception('Failed to fetch video feed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching video feed: $e');
    }
  }

  //fetch the SliderImage for the home page
  Future<List<SliderImage>> fetchSliderImages() async {
    final apiUri = "http://apjgsecure.jgo.tv/api/V1/sliderimage/";

    try {
      final token = await getToken();

      final response = await http.get(
        Uri.parse(apiUri),
        headers: {
          'a': 'f $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<SliderImage> sliderImages = data.map((json) => SliderImage.fromJson(json)).toList();
        return sliderImages;
      } else {
        throw Exception('Failed to fetch Slider Images: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching Slider Images: $e');
    }
  }


}
