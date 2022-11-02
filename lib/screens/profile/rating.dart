import 'package:flutter/material.dart';

import '../../constants/color_constants.dart';

class Rating extends StatefulWidget {
  const Rating({Key? key}) : super(key: key);

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          title: Text("Ratings",style: TextStyle(color: AppColors.black,fontSize: 25),),
          foregroundColor: AppColors.appblue,
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: AppColors.appblue,
            unselectedLabelColor: AppColors.black,
             labelColor: AppColors.appblue,
            tabs: [Tab(text: "Received"), Tab(text: "Given")],
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: Text("You haven't received any rating yet.")),
            Center(child: Text("You haven't received any rating yet.")),
          ],
        ),
      ),
    );
  }
}
