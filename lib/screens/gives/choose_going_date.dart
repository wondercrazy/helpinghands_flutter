import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/color_constants.dart';
import 'choose_going_time.dart';

class ChooseGoingDate extends StatefulWidget {
  const ChooseGoingDate({Key? key}) : super(key: key);

  @override
  State<ChooseGoingDate> createState() => _ChooseGoingDateState();
}

class _ChooseGoingDateState extends State<ChooseGoingDate> {
  TextEditingController timeinput = TextEditingController();

  @override
  void initState() {
    timeinput.text = "";
    super.initState();
  }

  TimeOfDay time = TimeOfDay.now();

  DateTime selectedDate = DateTime.now();
  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(

        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now().subtract(Duration(days: 0)),
        lastDate: DateTime.now().add(Duration(days: 364)));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
  addPrefDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('driverGoingToDate', "$selectedDate");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          addPrefDate();
          Navigator.push(context, MaterialPageRoute(builder: (context) =>ChooseGoingTime()));
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20,top: 20),
                  child: Text(
                    "When are you going?",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 30),
                    height: 100,
                    width: 200,
                    child: Center(
                        child: TextField(
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                      controller:
                          timeinput,
                      decoration: InputDecoration(
                        hintText:"${DateFormat("EEE, d MMM yyyy").format(selectedDate)}",

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      readOnly: true,
                      onTap: ()  {
                        _selectDate(context);
                      },
                    )),
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
