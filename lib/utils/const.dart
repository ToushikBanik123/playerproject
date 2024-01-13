import 'package:flutter/material.dart';

Color backgroundDarkBlue = Color(0XFF0C122A);
Color radioButtonBlue = Color(0XFF001B60);
Color radioTileBlue = Color(0XFF0E1733);
Color radioPlayerDarkBackgroundBlue = Color(0XFF000C26);
Color radioPlayerControllerBlue = Color(0XFF213C93);
Color liveRed = Color(0XFF950B00);

// Define the base URL
String baseUrl = "http://jago.ncare.io/";

// API Endpoints
String getTokenApi = baseUrl + "a/g-t/";
String liveCategoryApi = baseUrl + "livecategory";
String strabgimagegenartorApi = baseUrl + "api/V1/defultimages/";
String channelPlayUrlApi = baseUrl + "livetv/{id}/";
String dataAnalyticsApi = baseUrl + "api/V1/sgv2/analytics/tv/";
String playerPageBottomListApi = baseUrl + "api/V1/live-tv/";