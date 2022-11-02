import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../constants/color_constants.dart';

class CarDistraction extends StatefulWidget {
  const CarDistraction({Key? key}) : super(key: key);

  @override
  State<CarDistraction> createState() => _CarDistractionState();
}

class _CarDistractionState extends State<CarDistraction> {
  static String videoID = 'Zy1FyVwoDOA';

  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: videoID,
    flags: YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15, top: 20, bottom: 15),
                        child: Icon(Icons.arrow_back,
                            size: 30, color: AppColors.appblue),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      }),
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                  child: Text(
                    "Avoid distraction tips video",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: YoutubePlayer(
                    controller: _controller,
                    liveUIColor: AppColors.amber,
                    showVideoProgressIndicator: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
