// class ChannelCategory {
//   final String? catName;
//   final String? catSlug;
//   final String? catImage;
//   final List<LiveTV>? liveTVs;
//
//   ChannelCategory({
//     this.catName,
//     this.catSlug,
//     this.catImage,
//     this.liveTVs,
//   });
//
//   factory ChannelCategory.fromJson(Map<String, dynamic> json) {
//     return ChannelCategory(
//       catName: json['cat_name'],
//       catSlug: json['cat_slug'],
//       catImage: json['cat_image'],
//       liveTVs: List<LiveTV>.from((json['livetvs'] as List<dynamic>?)
//           ?.map((tv) => LiveTV.fromJson(tv))
//           .toList() ?? []),
//     );
//   }
// }
//
// class LiveTV {
//   final int id;
//   final String? channelName;
//   final String? channelLogo;
//   final String? strabgImageGenerator;
//
//   LiveTV({
//     required this.id,
//     this.channelName,
//     this.channelLogo,
//     this.strabgImageGenerator,
//   });
//
//   factory LiveTV.fromJson(Map<String, dynamic> json) {
//     return LiveTV(
//       id: json['id'],
//       channelName: json['channel_name'],
//       channelLogo: json['channel_logo'],
//       strabgImageGenerator: json['strabgimagegenartor'],
//     );
//   }
// }
//

class ChannelCategory {
  final String? catName;
  final String? catSlug;
  final String? catImage;
  final List<LiveTV>? liveTVs;

  ChannelCategory({
    this.catName,
    this.catSlug,
    this.catImage,
    this.liveTVs,
  });

  factory ChannelCategory.fromJson(Map<String, dynamic> json) {
    return ChannelCategory(
      catName: json['cat_name'],
      catSlug: json['cat_slug'],
      catImage: json['cat_image'],
      liveTVs: List<LiveTV>.from((json['livetvs'] as List<dynamic>?)
          ?.map((tv) => LiveTV.fromJson(tv))
          .toList() ?? []),
    );
  }
}

class LiveTV {
  final int id;
  final String? channelName;
  final String streamUrl; // New field
  final String? channelLogo;
  final String? strabgImageGenerator;

  LiveTV({
    required this.id,
    this.channelName,
    required this.streamUrl,
    this.channelLogo,
    this.strabgImageGenerator,
  });

  factory LiveTV.fromJson(Map<String, dynamic> json) {
    return LiveTV(
      id: json['id'],
      channelName: json['channel_name'],
      streamUrl: json['stream_url'], // Updated field name
      channelLogo: json['channel_logo'],
      strabgImageGenerator: json['strabgimagegenartor'],
    );
  }
}
