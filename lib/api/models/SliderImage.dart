import 'dart:convert';
import 'package:http/http.dart' as http;

class SliderImage {
  final int id;
  final String coverImage;

  SliderImage({required this.id, required this.coverImage});

  factory SliderImage.fromJson(Map<String, dynamic> json) {
    return SliderImage(
      id: json['id'],
      coverImage: json['coverimage'],
    );
  }
}