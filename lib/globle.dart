import 'package:flutter/material.dart';

buildContainerText(String text) {
  return
  Padding(
    padding: const EdgeInsets.only(top: 10,right: 10),
    child: Container(
      height: 50,
      width: 100,
      color: Colors.grey,
      child: Center(
          child: Text(
           text,
            style: TextStyle(fontSize: 20),
          )),
    ),
  );
}
