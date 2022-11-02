import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/color_constants.dart';
import 'add_about_ride.dart';

class ChooseGoingTime extends StatefulWidget {
  const ChooseGoingTime({Key? key}) : super(key: key);

  @override
  State<ChooseGoingTime> createState() => _ChooseGoingTimeState();
}

class _ChooseGoingTimeState extends State<ChooseGoingTime> {
  TextEditingController timeinput = TextEditingController();

  @override
  void initState() {
    timeinput.text = "";
    super.initState();
  }

  var selectedtime;
  TimeOfDay time = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('driverPickTime',
              "${selectedtime == null ? DateFormat("HH:mm a").format(new DateTime(2000, 1, 1, time.hour, time.minute)) : selectedtime}");
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddAboutYouRide()));
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
            // color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "What time will you pick passengers?",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  height: 100,
                  width: 200,
                  child: Center(
                      child: TextField(
                    style: TextStyle(fontSize: 35),
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.center,
                    controller: timeinput,
                    decoration: InputDecoration(
                      hintText:
                          // "${DateFormat.jm().parse(DateFormat("HH:mm").format(new DateTime(2000, 1, 1, time.hour, time.minute))).toString()}",
                          "${DateFormat("HH:mm a").format(new DateTime(2000, 1, 1, time.hour, time.minute))}" +
                              "",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    readOnly: true,
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                      );

                      if (pickedTime != null) {
                        DateTime parsedTime = DateFormat.jm()
                            .parse(pickedTime.format(context).toString());
                        String formattedTime =
                            DateFormat('HH:mm a').format(parsedTime);
                        setState(() {
                          timeinput.text = formattedTime;
                        });
                        selectedtime = pickedTime.format(context);
                      } else {
                        print("Time is not selected");
                      }
                    },
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
