import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helping_hands/screens/profile/type_vehicle.dart';

import '../../constants/color_constants.dart';

class ListVehicleBrand extends StatefulWidget {
  @override
  State<ListVehicleBrand> createState() => _ListVehicleBrandState();
}

class _ListVehicleBrandState extends State<ListVehicleBrand> {
  @override
  void initState() {
    super.initState();
    loadVault();
  }
  var catalogdata;
  List tempList = [];
  var distinctIds;
  loadVault() async {
    String jsonString = await rootBundle.loadString('assets/cars.json');
    final jsonResponse = json.decode(jsonString);
    var add = jsonResponse.toString();
    setState(() {
      catalogdata = json.decode(jsonString);
    });
    for (var i = 0; i < catalogdata.length; i++) {
      tempList.add(catalogdata[i]["name"]);
      distinctIds = tempList.toSet().toList();
    }
    return distinctIds;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
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
                    "What's Your vehicle's brand?",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                distinctIds == null
                    ? Container()
                    : Expanded(
                        child: ListView.builder(
                          itemCount: distinctIds.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 3,
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => KindVehicle(
                                          BrandName: distinctIds[index]),
                                    ),
                                  );
                                },
                                title: Text(
                                  "${distinctIds[index]}",
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
      ),
    );
  }
}
