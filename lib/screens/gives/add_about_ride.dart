import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helping_hands/constants/all_constants.dart';
import 'package:helping_hands/providers/addcarride_provider.dart';
import 'package:helping_hands/providers/profile_provider.dart';
import 'package:helping_hands/screens/home_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddAboutYouRide extends StatefulWidget {
  const AddAboutYouRide({Key? key}) : super(key: key);

  @override
  State<AddAboutYouRide> createState() => _AddAboutYouRideState();
}

class _AddAboutYouRideState extends State<AddAboutYouRide> {
  final TextEditingController _Textcontroller = TextEditingController();
  addPrefAboutRide() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('driverAboutRide', "${_Textcontroller.text}");
  }
  void addCarData(BuildContext context) {
    Provider.of<AddCarProvider>(context, listen: false).fetchAndAddDriverPrefData();
  }


  @override
  void initState() {
    super.initState();

  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          addPrefAboutRide();
          addCarData(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.appblue,
            borderRadius: BorderRadius.circular(50),
          ),
          width: 100,
          height: 50,
          child: Center(
              child: Text(
            "Publish",
            style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
          )),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          foregroundColor: AppColors.appblue),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            // color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: Text(
                    "Anything to add about your ride?",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                        // color: Colors.grey,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: _Textcontroller,
                            minLines: 5,
                            maxLines: 5,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                                // border: InputBorder.none,
                                hintText: 'Enter A Message Here',
                                hintStyle: TextStyle(color: AppColors.grey),
                                focusedBorder: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                  borderSide: BorderSide(color: AppColors.grey),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.grey, width: 2.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                fillColor: AppColors.greyshade300,
                                filled: true),
                          ),
                        ),
                      ),
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
