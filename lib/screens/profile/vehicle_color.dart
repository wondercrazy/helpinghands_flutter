import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/color_constants.dart';
import 'car_made.dart';

class VehicleColor extends StatefulWidget {
  const VehicleColor({Key? key}) : super(key: key);

  @override
  State<VehicleColor> createState() => _VehicleColorState();
}

class _VehicleColorState extends State<VehicleColor> {
  List colors = [
    Colors.blue,
    Colors.orange,
    Colors.black,
    Colors.white,
    Colors.red,
    Colors.yellow,
    Colors.grey,
    Colors.green
  ];
  var colorName = [
    "Blue",
    "Orange",
    "Black",
    "White",
    "Red",
    "Yellow",
    "Grey",
    "green"
  ];
  String selectedColor ='';
  addPrefvehiclecolor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('vehiclecolor', "${selectedColor}");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),

          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    child: Icon(Icons.arrow_back,
                        size: 30, color: AppColors.appblue),
                    onTap: () {
                      Navigator.pop(context);
                    }),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 40, bottom: 40),
                  child: Text(
                    "What is your vehicle color?",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),

                ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: colorName.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 3,
                      child: ListTile(
                          onTap: () {
                            setState(() {
                              selectedColor = colorName[index];
                            });
                            addPrefvehiclecolor();
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CarMade(),
                            ));
                          },
                          leading: CircleAvatar(
                              backgroundColor:AppColors.black, radius: 17,
                            child: CircleAvatar(
                                backgroundColor: colors[index], radius: 15),
                          ),
                          title: Text("${colorName[index].toString()}")),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
