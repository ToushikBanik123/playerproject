import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../Provider/AppProvider.dart';
import '../utils/const.dart';
import 'MyDrawer.dart';
import 'liveTvPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      appBar: AppBar(backgroundColor: backgroundDarkBlue,elevation: 0,),
      backgroundColor: backgroundDarkBlue,
      endDrawer: MyDrawer(),
      body: Column(
        children: [
          Expanded(
            child: Consumer<AppProvider>(
              builder: (context, provider, child) {
                return LiveTvPage();
              },
            ),
          ),
        ],
      ),
      // bottomSheet: MiniPlayerUi(),
      // drawer: Drawer(),
    );
  }
}





