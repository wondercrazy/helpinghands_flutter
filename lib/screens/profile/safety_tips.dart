import 'package:flutter/material.dart';

import '../../constants/color_constants.dart';
import 'car_covid.dart';
import 'car_distraction.dart';
import 'car_driver_safety.dart';

class SafetyTips extends StatefulWidget {
  const SafetyTips({Key? key}) : super(key: key);

  @override
  State<SafetyTips> createState() => _SafetyTipsState();
}

class _SafetyTipsState extends State<SafetyTips> {
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
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: Text(
                  "Safety tips for drivers",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Image.asset(
                  "assets/images/driversafety.jpeg",
                  fit: BoxFit.fill,
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(left: 70, right: 70, top: 10, bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CarDriverSafety(),
                          ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Read more',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(), primary: AppColors.green),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: Divider(color: AppColors.grey, thickness: 2),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: Text(
                  "How to avoide distracion while driving?",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Image.asset(
                  "assets/images/distractioncar.jpeg",
                  fit: BoxFit.fill,
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(left: 70, right: 70, top: 10, bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CarDistraction(),
                          ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Play the video',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(), primary: AppColors.green),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: Divider(color: AppColors.grey, thickness: 2),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: Text(
                  "Some tips for COVID-19",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Image.asset(
                  "assets/images/drivercaronasafety.jpeg",
                  fit: BoxFit.fill,
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(left: 70, right: 70, top: 10, bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CarCovid(),
                          ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Read more',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(), primary: AppColors.green),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
