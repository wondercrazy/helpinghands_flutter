import 'package:flutter/material.dart';

import '../../constants/color_constants.dart';

class CarCovid extends StatefulWidget {
  const CarCovid({Key? key}) : super(key: key);

  @override
  State<CarCovid> createState() => _CarCovidState();
}

class _CarCovidState extends State<CarCovid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, top: 20),
                        child: Icon(Icons.arrow_back,
                            size: 30, color: AppColors.appblue),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      }),
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20,
                      top: 10,
                      bottom: 10
                  ),
                  child: Text(
                    "COVID-19 instructions for drivers and passangers.",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Image.asset(
                  "assets/images/covid.png",
                  fit: BoxFit.fill,
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Image.asset(
                  "assets/images/covid1.jpeg",
                  fit: BoxFit.fill,
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20,bottom: 20),
                child: Image.asset(
                  "assets/images/cardriversafety.webp",
                  fit: BoxFit.fill,
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
