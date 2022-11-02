import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants/color_constants.dart';

class DriverRating extends StatefulWidget {
  const DriverRating({Key? key}) : super(key: key);

  @override
  State<DriverRating> createState() => _DriverRatingState();
}

class _DriverRatingState extends State<DriverRating> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          foregroundColor: AppColors.appblue),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: AppColors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25, left: 20, bottom: 10),
                  child: Text(
                    "Ratings",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.star),
                  title: Text("5/5 - 2 rating"),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 10),
                  child: Divider(
                    height: 2,
                    color: AppColors.grey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: ListTile(
                    leading: Icon(Icons.star),
                    title: Text("5"),
                    trailing: Text("2"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: ListTile(
                    leading: Icon(Icons.star),
                    title: Text("4"),
                    trailing: Text("0"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: ListTile(
                    leading: Icon(Icons.star),
                    title: Text("3"),
                    trailing: Text("0"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: ListTile(
                    leading: Icon(Icons.star),
                    title: Text("2"),
                    trailing: Text("0"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: ListTile(
                    leading: Icon(Icons.star),
                    title: Text("1"),
                    trailing: Text("0"),
                  ),
                ),
                Divider(
                  thickness: 5,
                  color: AppColors.greyshade300,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(user!.photoURL!),
                          ),
                          title: Text(
                            user!.displayName!,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, top: 30),
                        child: Text(
                          "5 ☆☆☆☆☆",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, top: 5),
                        child: Text("It was a great ride with sir.",
                            style: TextStyle(fontSize: 16)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, top: 2),
                        child: Text(
                          "23 jul - 07:20",
                          style: TextStyle(color: AppColors.grey),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Divider(
                    height: 2,
                    color: AppColors.grey,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
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
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, top: 30),
                        child: Text(
                          "5 ☆☆☆☆☆",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, top: 5),
                        child: Text("It was a great ride with sir.",
                            style: TextStyle(fontSize: 16)),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 30, top: 2, bottom: 20),
                        child: Text(
                          "23 jul - 07:20",
                          style: TextStyle(color: AppColors.grey),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
