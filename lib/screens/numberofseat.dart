import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helping_hands/constants/all_constants.dart';
import 'package:helping_hands/providers/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NumberOfSeat extends StatefulWidget {
  const NumberOfSeat({Key? key}) : super(key: key);

  @override
  State<NumberOfSeat> createState() => _NumberOfSeatState();
}

class _NumberOfSeatState extends State<NumberOfSeat> {
  var _weight = 1;

  @override
  void initState() {
    super.initState();
  }

  addPrefSeatBook() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('searchSeatBook', "$_weight");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          addPrefSeatBook();
          Navigator.pop(context);
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.appblue,
          ),
          width: 60,
          height: 60,
          child: Center(
              child: Icon(
            Icons.arrow_forward_sharp,
            size: 30,
            color: AppColors.white,
          )),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildGestureDetector(Icon(Icons.close, size: 30, color: AppColors.appblue),
                     () {
                      Navigator.pop(context);
                    }),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 40, bottom: 40),
                  child: Text(
                    "Number of seat to book",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    buildGestureDetector(
                      Icon(
                        Icons.remove_circle_outline_rounded,
                        size: 50,
                        color: AppColors.appblue,
                      ),
                      () {
                        setState(() {
                          if (_weight > 1) _weight--;
                        });
                      },
                    ),
                    Text(
                      "$_weight",
                      style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 80.0,
                      ),
                    ),
                    buildGestureDetector(
                      Icon(
                        Icons.add_circle_outline,
                        size: 50,
                        color: AppColors.appblue,
                      ),
                      () {
                        setState(() {
                          if (_weight < 9) _weight++;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector buildGestureDetector(Icon icon, ontap) {
    return GestureDetector(child: icon, onTap: ontap);
  }
}
