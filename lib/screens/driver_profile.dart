import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helping_hands/screens/profile/driver_rating.dart';

import '../constants/color_constants.dart';

class DriverProfile extends StatefulWidget {
  const DriverProfile({Key? key}) : super(key: key);

  @override
  State<DriverProfile> createState() => _DriverProfileState();
}

class _DriverProfileState extends State<DriverProfile> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor:AppColors.white,
            elevation: 0,
            foregroundColor: AppColors.appblue),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              color: AppColors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Container(
                      width: double.infinity,
                      // height: 200,
                      child: Container(
                        alignment: Alignment(0.0, 2.5),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(user!.photoURL!),
                          radius: 60.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      user!.displayName!,
                      // "Helping Hands",
                      style: TextStyle(
                          fontSize: 25.0,
                          color: AppColors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      "surat, India",
                      style: TextStyle(
                          fontSize: 18.0,
                          color: AppColors.black,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      "33 y/o",
                      style: TextStyle(
                          fontSize: 15.0,
                          color: AppColors.black45,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Card(
                    margin:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "Rides Published",
                                  style: TextStyle(
                                      color: AppColors.blueAccent,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  "15",
                                  style: TextStyle(
                                      color: AppColors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w300),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "Memeber since",
                                  style: TextStyle(
                                      color: AppColors.blueAccent,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  "jul 2022",
                                  style: TextStyle(
                                      color: AppColors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w300),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(
                            "About Me",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )),
                      Container(
                          margin: EdgeInsets.only(left: 20),
                          child: ListTile(
                              leading: Icon(Icons.chat),
                              title: Text(
                                "I tolk depending on my mood",
                                style: TextStyle(fontSize: 18),
                              ))),
                      Container(
                          margin: EdgeInsets.only(left: 20),
                          child: ListTile(
                              leading: Icon(Icons.person_pin),
                              title: Text("Max. 2 in the back seats",
                                  style: TextStyle(fontSize: 18)))),
                      Container(
                          margin: EdgeInsets.only(left: 20),
                          child: ListTile(
                              leading: Icon(Icons.smoke_free),
                              title: Text("No smoking",
                                  style: TextStyle(fontSize: 18)))),
                      Container(
                          margin: EdgeInsets.only(left: 20),
                          child: ListTile(
                              leading: Icon(Icons.pets),
                              title: Text("No pets",
                                  style: TextStyle(fontSize: 18)))),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Divider(
                      color: AppColors.grey,
                      height: 2,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 20, top: 20),
                            child: Text(
                              "Rating",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DriverRating()));
                          },
                          child: ListTile(
                            leading: Icon(Icons.star),
                            title: Text(
                              "4.5/5 - 5 rating",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios_rounded),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton(
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0),
                        ),
                        color: AppColors.white,
                        elevation: 0,
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [AppColors.pink, AppColors.redAccent]),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: 120.0,
                              maxHeight: 40.0,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "Contact me",
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 18.0,
                                  letterSpacing: 2.0,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
