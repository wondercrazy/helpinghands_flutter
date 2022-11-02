import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helping_hands/constants/all_constants.dart';
import 'package:helping_hands/providers/profile_provider.dart';
import 'package:helping_hands/screens/driver_profile.dart';
import 'package:helping_hands/screens/profile/rating.dart';
import 'package:helping_hands/screens/profile/safety.dart';
import 'package:helping_hands/screens/profile/setting.dart';
import 'package:provider/provider.dart';

import '../../models/editprofile.dart';
import 'car.dart';
import 'edit_profile.dart';
import 'faq.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late ProfileProvider profileProvider;

  @override
  void initState() {
    super.initState();
    profileProvider = context.read<ProfileProvider>();
    readLocal();
    updateEditProfile();
    // isItems();
  }

  String dialCodeDigits = '+00';
  String id = '';
  String displayName = '';
  String name = '';
  String photoUrl = '';
  String phoneNumber = '';
  String email = '';
  String address = '';

  void readLocal() {
    setState(() {
      id = profileProvider.getPrefs(FirestoreConstants.id) ?? "";
      displayName =
          profileProvider.getPrefs(FirestoreConstants.displayName) ?? "";
      name = profileProvider.getPrefs(FirestoreConstants.name) ?? "";

      photoUrl = profileProvider.getPrefs(FirestoreConstants.photoUrl) ?? "";
      phoneNumber =
          profileProvider.getPrefs(FirestoreConstants.phoneNumber) ?? "";
      email = profileProvider.getPrefs(FirestoreConstants.email) ?? "";
      address = profileProvider.getPrefs(FirestoreConstants.address) ?? "";
    });
  }

  Future<void> updateEditProfile() async {
    profileProvider = context.read<ProfileProvider>();
    id = profileProvider.getPrefs(FirestoreConstants.id) ?? "";

    var collection = FirebaseFirestore.instance
        .collection(FirestoreConstants.pathUserCollection);
    collection.doc(id).collection("editProfile").doc();


    CollectionReference collectionReference = collection.doc(id).collection("editProfile");
    QuerySnapshot querySnapshot = await collectionReference.get();
    if(querySnapshot.docs.isNotEmpty == false){
      return
        collection
            .doc(id)
            .collection('editProfile')
            .doc("eid")
            .set({
          'name': user!.displayName,
          'email': user!.email,
          'phonenumber': "",
          'address': ""
        })
            .then((value) => print("update successfully"))
            .catchError((error) => print("failed update user $error"));
    }

  }
  
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    // searchVehicleprovider= Provider.of(context);
    return Scaffold(
      appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.only(left: 10),
                // child: CircleAvatar(
                child: IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                  icon: Icon(Icons.menu, size: 25),
                ),
              );
            },
          ),
          centerTitle: true,
          title: const Text(
            'Profile',
            style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
          backgroundColor: AppColors.white,
          elevation: 0,
          foregroundColor: AppColors.appblue),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            new SizedBox(
              height: 100.0,
              child: new DrawerHeader(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.white)),
                    // ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          email,
                          style: TextStyle(color: AppColors.black45),
                        ),
                      ),
                    ),
                  ],
                ),
                decoration: new BoxDecoration(color: AppColors.blueshade600),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.directions_car_filled_rounded,
                size: 30,
              ),
              title: const Text(
                'Add a Car',
                style: TextStyle(fontSize: 17),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CarAddData(),
                ));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.health_and_safety_sharp,
                size: 30,
              ),
              title: const Text(
                'Safety',
                style: TextStyle(fontSize: 17),
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Safety()));
              },
            ),
            // ),
            ListTile(
              leading: Icon(
                Icons.chat_rounded,
                size: 30,
              ),
              title: const Text(
                'Support',
                style: TextStyle(fontSize: 17),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.star_border_outlined,
                size: 30,
              ),
              title: const Text(
                'Rating',
                style: TextStyle(fontSize: 17),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Rating(),
                ));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.info_outline,
                size: 30,
              ),
              title: const Text(
                'FAQ',
                style: TextStyle(fontSize: 17),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FAQ(),
                ));
              },
            ),

            ListTile(
              leading: Icon(
                Icons.settings_outlined,
                size: 30,
              ),
              title: const Text(
                'Setting',
                style: TextStyle(fontSize: 17),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Setting(),
                ));
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            Completer<Null> completer = new Completer<Null>();
            await Future.delayed(Duration(seconds: 1)).then((onvalue) {
              completer.complete();
              setState(() {
                readLocal();
              });
            });
            return completer.future;
          },
          child: ListView(children: [
            SingleChildScrollView(
              child: Container(
                color: AppColors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment(0.0, 2.5),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          user!.photoURL!,
                        ),
                        radius: 90.0,
                      ),
                    ),

                    // Container(
                    //   decoration: BoxDecoration(
                    //       image: DecorationImage(
                    //           image: NetworkImage(
                    //               'https://media.istockphoto.com/photos/illustration-of-generic-compact-white-car-front-side-view-picture-id1150931120?k=20&m=1150931120&s=612x612&w=0&h=Jgokrl3DwEc1VUKNf5H3lH3lyg6yPQVobdELPn4zNsc='),
                    //           fit: BoxFit.cover)),
                    //   child: Container(
                    //     width: double.infinity,
                    //     height: 200,
                    //     // child: Container(
                    //     //   alignment: Alignment(0.0, 2.5),
                    //     //   child: CircleAvatar(
                    //     //     backgroundImage: NetworkImage(
                    //     //       user!.photoURL!,
                    //     //     ),
                    //     //     radius: 60.0,
                    //     //   ),
                    //     // ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    StreamBuilder<List<EditProfiles>>(
                      stream: readEditProfileData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("somthing is wrong ${snapshot.hasError}");
                        } else if (snapshot.hasData) {
                          final users = snapshot.data!;
                          return ListView(
                              shrinkWrap: true,
                              children: users.map(buildEditProfiles).toList());
                          //   Center(
                          //   child: Text(
                          //     users.,
                          //     style: TextStyle(
                          //         fontSize: 25.0,
                          //         color: AppColors.black,
                          //         fontWeight: FontWeight.bold),
                          //   ),
                          // );
                        } else
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                      },
                    ),

                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Center(
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(left: 10, right: 10),
                    //     child: Text(
                    //       address,
                    //       maxLines: 1,
                    //       overflow: TextOverflow.ellipsis,
                    //       // "surat, India",
                    //       style: TextStyle(
                    //           fontSize: 18.0,
                    //           color: AppColors.black,
                    //           fontWeight: FontWeight.w300),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Center(
                    //   child: Text(
                    //     phoneNumber,
                    //     style: TextStyle(
                    //         fontSize: 15.0,
                    //         color: AppColors.black87,
                    //         letterSpacing: 2.0,
                    //         fontWeight: FontWeight.w300),
                    //   ),
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 30, right: 30),
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                AppColors.greyshade400)),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditProfile(),
                          )); //EditProfile()
                        },
                        child: Text(
                          "EDIT PROFILE",
                          style: TextStyle(color: AppColors.black),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 30, right: 30),
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                AppColors.blueshade400)),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DriverProfile(),
                          ));
                        },
                        child: Text("SEE MY PUBLIC PROFILE"),
                      ),
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
                                        //Colors.blueAccent,
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
                                    "Rides Takes",
                                    style: TextStyle(
                                        color: AppColors.blueAccent,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    "22",
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
                    //
                    // Row(
                    //   children:searchVehicleprovider!.getserchVehicleDetails.map((serchvehicleData){
                    //    // ListView.builder(itemBuilder: (context, index) => ,)
                    //    return Text(serchvehicleData.searchStartingPoint);
                    //   }).toList(),
                    // )
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Stream<List<EditProfiles>> readEditProfileData() => FirebaseFirestore.instance
      .collection(FirestoreConstants.pathUserCollection)
      .doc(id)
      .collection("editProfile")
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => EditProfiles.fromJson(doc.data()))
          .toList());

  Widget buildEditProfiles(EditProfiles editProfiles) => Column(
        children: [
          Center(
            child: Text(
              "${editProfiles.name}",
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
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                "${editProfiles.address}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                // "surat, India",
                style: TextStyle(
                    fontSize: 18.0,
                    color: AppColors.black,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              "${editProfiles.phonenumber}", // phoneNumber,
              style: TextStyle(
                  fontSize: 15.0,
                  color: AppColors.black87,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300),
            ),
          ),
        ],
      ); //Center(child: Text("${editProfiles.name}")),
}
