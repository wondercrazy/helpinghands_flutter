import 'package:flutter/material.dart';

import '../../constants/color_constants.dart';

class FAQ extends StatefulWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "FAQ",
            style: TextStyle(
                color: AppColors.black, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: AppColors.white,
          elevation: 0,
          foregroundColor: AppColors.appblue),
      body: SafeArea(
        child: Center(
          child: Text("App Instruction"),
        ),
      ),
    );
  }
}
