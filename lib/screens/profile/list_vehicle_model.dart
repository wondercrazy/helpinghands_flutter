import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helping_hands/screens/profile/vehicle_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/color_constants.dart';

class ListVehicleModel extends StatefulWidget {
  final BrandCategory;
  final BrandName;

  ListVehicleModel(
      {super.key, required this.BrandCategory, required this.BrandName});

  @override
  State<ListVehicleModel> createState() => _ListVehicleModelState();
}

class _ListVehicleModelState extends State<ListVehicleModel> {
  @override
  void initState() {
    super.initState();
    loadVault2();
  }

  Future<String> _loadAVaultAsset2() async {
    return await rootBundle.loadString('assets/cars.json');
  }

  List catalogdata2 = [];
  List tempList2 = [];
  var distinctIds2;

  Future loadVault2() async {
    String jsonString = await _loadAVaultAsset2();
    final jsonResponse = json.decode(jsonString);
    var add = jsonResponse.toString();
    setState(() {
      catalogdata2 = json.decode(jsonString);
    });
    for (var i = 0; i < catalogdata2.length; i++) {
      if (catalogdata2[i]["name"].toString() == "${widget.BrandName}" &&
          catalogdata2[i]["category"].toString() == "${widget.BrandCategory}") {
        tempList2.add(catalogdata2[i]["model"]);
        distinctIds2 = tempList2.toSet().toList();
      }
    }
  }

  String selectedModel = "";
  addPrefvehicle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('vehicleBrandName', "${widget.BrandName}");
    prefs.setString('vehicleBrandCategory', "${widget.BrandCategory}");
    prefs.setString('vehicleBrandModel', "${selectedModel}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  child: Icon(Icons.arrow_back, size: 30, color: AppColors.appblue),
                  onTap: () {
                    Navigator.pop(context);
                  }),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 40, bottom: 40),
                child: Text(
                  "What kind of vehicle is it?",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              distinctIds2 == null
                  ? Container()
                  : Expanded(
                      child: ListView.builder(
                        itemCount: distinctIds2.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 3,
                            child: ListTile(
                              onTap: () {
                                setState(() {
                                  selectedModel = distinctIds2[index];
                                });
                                addPrefvehicle();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VehicleColor(),
                                  ),
                                );
                              },
                              title: Text(
                                "${distinctIds2[index]}",
                                style: TextStyle(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios_rounded),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
