import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helping_hands/screens/profile/upload_car_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/color_constants.dart';

class CarMade extends StatefulWidget {
  const CarMade({Key? key}) : super(key: key);

  @override
  State<CarMade> createState() => _CarMadeState();
}
class _CarMadeState extends State<CarMade> {
  final TextEditingController _yearController = TextEditingController();
  String vehicleyear = "";
  addPrefvehicleYear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('vehicleYear', "${vehicleyear}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: (vehicleyear == "" && vehicleyear.length == 0)
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
          : GestureDetector(
              onTap: () {
                addPrefvehicleYear();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => UploadCarImage(),
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
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: GestureDetector(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                      child:
                          Icon(Icons.arrow_back, size: 30, color: AppColors.appblue),
                      onTap: () {
                        Navigator.pop(context);
                      }),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 40, bottom: 40),
                    child: Text(
                      "When was your vehicle made? Passengers like to know.",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 20),
                    child: TextFormField(
                      keyboardType: TextInputType.numberWithOptions(),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(
                            4) // only allow 5 digit number
                      ],
                      // keyboardType: TextInputType.number,
                      controller: _yearController,
                      textAlign: TextAlign.left,
                      cursorColor: AppColors.grey,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Ex 2010",
                        floatingLabelStyle:
                            const TextStyle(height: 4, color: AppColors.grey),
                        filled: true,
                        fillColor: AppColors.greyshade200,
                      ),
                      onChanged: (value) {
                        setState(() {});
                        vehicleyear = value;
                      },
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
