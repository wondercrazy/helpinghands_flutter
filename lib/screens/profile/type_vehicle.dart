import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants/color_constants.dart';
import 'list_vehicle_model.dart';

class KindVehicle extends StatefulWidget {
  final BrandName;

  KindVehicle({super.key, required this.BrandName});

  @override
  State<KindVehicle> createState() => _KindVehicleState();
}

class _KindVehicleState extends State<KindVehicle> {
  @override
  void initState() {
    super.initState();
    loadVault1();
  }

  Future<String> _loadAVaultAsset1() async {
    return await rootBundle.loadString('assets/cars.json');
  }

  List catalogdata1 = [];
  List tempList1 = [];
  var distinctIds1;
  Future loadVault1() async {
    String jsonString = await _loadAVaultAsset1();
    final jsonResponse = json.decode(jsonString);
    var add = jsonResponse.toString();
    setState(() {
      catalogdata1 = json.decode(jsonString);
    });
    for (var i = 0; i < catalogdata1.length; i++) {
      if (catalogdata1[i]["name"].toString() == "${widget.BrandName}") {
        tempList1.add(catalogdata1[i]["category"]);
        distinctIds1 = tempList1.toSet().toList();
      }
    }
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
              distinctIds1 == null
                  ? Container()
                  : Expanded(
                      child: ListView.builder(
                        itemCount: distinctIds1.length ?? 0,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 3,
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ListVehicleModel(
                                        BrandCategory: distinctIds1[index],
                                        BrandName: widget.BrandName),
                                  ),
                                );
                              },
                              title: Text(
                                "${distinctIds1[index]}",
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
