import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helping_hands/models/vehiclesearch.dart';
import 'package:helping_hands/providers/addcarride_provider.dart';
import 'package:helping_hands/screens/driver_profile.dart';
import 'package:provider/provider.dart';

import '../../constants/color_constants.dart';

class SearchRides extends StatefulWidget {
  final startingPoint, endPoint;

  //,startTime,carName,carColor;
  SearchRides(
      {this.startingPoint,
      this.endPoint}); //,this.startTime,this.carName,this.carColor

  @override
  State<SearchRides> createState() => _SearchRidesState();
}

class _SearchRidesState extends State<SearchRides> {
  User? user = FirebaseAuth.instance.currentUser;
  AddCarProvider? driverlisttemp;


  @override
  void initState() {
    driverlisttemp = Provider.of<AddCarProvider>(context, listen: false);
    fetchdata(context);
    //checkData();
    super.initState();
  }

  void fetchdata(BuildContext context) {
    Provider.of<AddCarProvider>(context, listen: false).getDriverAllData();
    Provider.of<AddCarProvider>(context, listen: false).getSearchAllData();
  }

  List<String> badWords = ["Surat"];
  List<String> sentences = [
    "New Pal Road, Surat, 395009, India",
  ];

  checkData() {
    for (String sentence in sentences) {
      if (isSentenceOffensive(sentence, badWords)) {
        print('$sentence');
        print('$sentence');
      }
    }
  }

  bool isSentenceOffensive(String sentence, List<String> badWords) {
    List<String> words = sentence.split(RegExp(r"[., ]"));
    for (String word in words) {
      if (badWords.contains(word)) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    var read = context.watch<AddCarProvider>();
    // print(" driver List : ---------  ${read.newList.map((e) => e.driverStartingPoint.toString())}");
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.white,
          elevation: 0,
          foregroundColor: AppColors.appblue,
          title: Text(
            "Choose a trip",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: AppColors.black, fontSize: 25),
          ),
        ),
        body:
            // SafeArea(
            //   child: SingleChildScrollView(
            //     child:
            // Column(
            //   children: [
            //     GestureDetector(
            //       onTap: () {
            //         Navigator.of(context).push(
            //             MaterialPageRoute(builder: (context) => DriverProfile()));
            //       },
            //       child:
            ListView.builder(
          itemBuilder: (context, index) {
            return Container(
              height: 270,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                color: AppColors.white,
                margin: EdgeInsets.only(right: 15.0, left: 15.0, top: 5),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 10),
                              height: 20,
                              width: 60,
                              child: Text("12:00", //"${widget.startTime}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))),
                          Container(
                            margin: const EdgeInsets.only(left: 8, right: 5),
                            height: 18,
                            width: 18,
                            decoration: BoxDecoration(
                                color: AppColors.red,
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColors.black)),
                          ),
                          Expanded(
                              child: Text(
                                  widget.startingPoint, //==
                                          // read.driverStartingPoint![index]
                                      // ? widget.startingPoint
                                      // : "not match", //"Surat",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  //textAlign: ,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))),
                          Expanded(
                            child: Column(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: FittedBox(
                                      fit: BoxFit.cover,
                                      child: Text(
                                        "VOLKSWAGEN AMEO", //MARUTI SWIFT
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.green),
                                      ),
                                    )),
                                Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: FittedBox(
                                      fit: BoxFit.cover,
                                      child: Text(
                                        "RED",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.green),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 86),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 40),
                        decoration: const BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: AppColors.red,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 10),
                              height: 20,
                              width: 60,
                              child: Text("15:00",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))),
                          Container(
                            margin: const EdgeInsets.only(left: 8, right: 5),
                            height: 18,
                            width: 18,
                            decoration: BoxDecoration(
                                color: AppColors.red,
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColors.black)),
                          ),
                          Expanded(
                            child: Text(
                                "${read.driverDestinationPoint[index]}" ==
                                        widget.endPoint
                                    ? widget.endPoint
                                    : "not match", //"vadodra",
                                //widget.endPoint == read.driverDestinationPoint![index] ? widget.endPoint : "not match",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 20),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                              user!.photoURL!,
                            ),
                          ),
                          title: Text(
                            user!.displayName!,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          subtitle: Row(children: [
                            Icon(Icons.star),
                            Text(
                              " 4.5",
                              style: TextStyle(fontSize: 16),
                            )
                          ]),
                          trailing: Icon(Icons.arrow_forward_ios_rounded),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          itemCount: read.searchDriverList.length,
        )
        // ),
        // ],
        // ),
        // ),
        // ),
        );
  }
}
