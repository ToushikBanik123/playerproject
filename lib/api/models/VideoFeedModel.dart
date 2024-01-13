import 'dart:convert';
import 'package:http/http.dart' as http;

class VideoFeedModel {
  final String? channelName;
  final String? streamUrl;
  final String? streamUrl2;
  final String? channelLogo;
  final String? channelLogoUrl;

  VideoFeedModel({
    required this.channelName,
    required this.streamUrl,
    required this.streamUrl2,
    required this.channelLogo,
    required this.channelLogoUrl,
  });

  factory VideoFeedModel.fromJson(Map<String, dynamic> json) {
    return VideoFeedModel(
      channelName: json['channel_name'],
      streamUrl: json['stream_url'],
      streamUrl2: json['stream_url_2'],
      channelLogo: json['channel_logo'],
      channelLogoUrl: json['channel_logo_url'],
    );
  }
}
