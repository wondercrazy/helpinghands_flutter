import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:helping_hands/screens/profile/safety_tips.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/color_constants.dart';

class Safety extends StatefulWidget {
  const Safety({Key? key}) : super(key: key);

  @override
  State<Safety> createState() => _SafetyState();
}

class _SafetyState extends State<Safety> {
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
                        padding: const EdgeInsets.only(left: 15, top: 20),
                        child:
                            Icon(Icons.arrow_back, size: 30, color: AppColors.appblue),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      }),
                ],
              ),
              SvgPicture.asset('assets/images/safety.svg', height: 300),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 0,
                  ),
                  child: Text(
                    "Who do you want to contact?",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 50, bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {launch("tel:102");},
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Ambulance',
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
              Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {launch("tel:100");},
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Police',
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
              Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SafetyTips(),));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Safety tips',
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
              Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Message support',
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
