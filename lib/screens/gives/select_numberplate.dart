import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helping_hands/screens/profile/car.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/color_constants.dart';
import '../../providers/addvehicle_provider.dart';
import 'choose_going_date.dart';

class SelectNumberPlate extends StatefulWidget {
  const SelectNumberPlate({Key? key}) : super(key: key);

  @override
  State<SelectNumberPlate> createState() => _SelectNumberPlateState();
}

class _SelectNumberPlateState extends State<SelectNumberPlate> {
  var plateNumber;

  // var read;
  // var a;

  @override
  void initState() {
    super.initState();
    Provider.of<AddVehicleProvider>(context, listen: false).readLocal();
    // read = context.watch<AddVehicleProvider>();

  }
  addPrefDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedDropDownNumberPlate', "$plateNumber");
  }

  @override
  Widget build(BuildContext context) {
    var read = context.watch<AddVehicleProvider>();
    return Scaffold(
      floatingActionButton: (read.vehicleLicensePlateNumber == null || plateNumber==null)
              ? Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.grey,
            ),
            width: 60,
            height: 60,
            child: Center(
                child: Icon(
                  Icons.arrow_forward_sharp,
                  size: 30,
                  color: AppColors.white,
                )),
          )
              :
          GestureDetector(
        onTap: () {
          addPrefDate();
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ChooseGoingDate(),
          ));
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
      appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          foregroundColor: AppColors.appblue),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // GestureDetector(
                  //     child:
                  //         Icon(Icons.close, size: 30, color: AppColors.appblue),
                  //     onTap: () {
                  //       Navigator.pop(context);
                  //     }),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 40, bottom: 40),
                    child: Text(
                      "Select Your License plate number?",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  (read.vehicleLicensePlateNumber != null && read.vehicleLicensePlateNumber.length !=0 ) ? DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.greyshade200,
                        //background color of dropdown button
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: DropdownButton(
                            hint: Text('Pickup License plate number '),
                            value: plateNumber,
                            items: read.vehicleLicensePlateNumber
                                .map<DropdownMenuItem<String>>((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),

                            onChanged: (value) {
                              setState(() {
                                plateNumber = value;
                              });
                            },
                            icon: Padding(
                                //Icon at tail, arrow bottom is default icon
                                padding: EdgeInsets.only(left: 20),
                                child:
                                    Icon(Icons.arrow_drop_down_circle_rounded)),
                            iconEnabledColor: AppColors.black54,
                            style: TextStyle(

                                color: AppColors.black54,
                                fontSize: 18
                                ),

                            dropdownColor: AppColors.greyshade200,
                            underline: Container(),
                            isExpanded: true,
                          ))) :
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CarAddData()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextFormField(
                        // controller: _numberPlateController,
                        textAlign: TextAlign.center,
                        enabled: false,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide.none,
                          ),
                          // labelText: "GJ 21 AA 1234",
                          hintText: "Add Your Vehicle",
                          hintStyle:
                              TextStyle(color: AppColors.white, fontSize: 18),
                          filled: true,
                          fillColor: AppColors.appblue,
                        ),
                        onChanged: (value) {
                          // plateNumber = value;
                          // setState(() {
                          //   plateNumber;
                          // });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
