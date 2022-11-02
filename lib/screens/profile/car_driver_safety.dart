import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../constants/color_constants.dart';

class CarDriverSafety extends StatefulWidget {
  const CarDriverSafety({Key? key}) : super(key: key);

  @override
  State<CarDriverSafety> createState() => _CarDriverSafetyState();
}

class _CarDriverSafetyState extends State<CarDriverSafety> {
  List Videoid = [
    'rKDVgo0D2qc',
    'ZXEDTUniebw',
    "DCXGOYm1pmw",
    "bHrA9tYC0d4",
    "jjWSWxeGxxs",
    "JSW7CIFpB8c",
    "g3qG0KCZ_PY",
    "OJbmnt6J5I8",
    "v_32OgDc2vw",
    "ByZ5JZ8Ry0M",
    "i5oTvPYrtkk"
  ];
  List title = [
    "1. Do not drink and drive.",
    "2. Keep a safe distance from vehicles!",
    "3. Buckle up before you drive.",
    "4. Do not drive on the wrong side.",
    "5. Always wear a helmet!.",
    "6. Always give an indicator while changing lanes.",
    "7. Drive within the speed limits.",
    "8. Don't use mobile phones while driving.",
    "9. Do not jay walk. Cross the road safely and use the zebra crossing.",
    "10. Be patient while driving!.",
    "11. Do not honk unnecessarily!."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          foregroundColor: AppColors.appblue),
      body: SafeArea(
        child: ListView.builder(
            itemCount: Videoid.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    child: Text(
                      "${title[index]}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    child: Container(
                      child: YoutubePlayer(
                        controller: YoutubePlayerController(
                          initialVideoId: Videoid[index],
                          flags: YoutubePlayerFlags(
                            autoPlay: false,
                            mute: false,
                          ),
                        ),
                        liveUIColor: AppColors.amber,
                        showVideoProgressIndicator: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
                    child: Divider(color: AppColors.grey,thickness: 2),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
