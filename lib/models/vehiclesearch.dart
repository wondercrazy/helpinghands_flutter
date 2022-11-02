import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/firestore_constants.dart';
import '../providers/profile_provider.dart';
VehicleTypes vehicleTypesFromJson(String str) => VehicleTypes.fromJson(json.decode(str));

String vehicleTypesToJson(VehicleTypes data) => json.encode(data.toJson());

class VehicleTypes {
  VehicleTypes({
    this.searchStartingPoint,
    this.serchEndPoints,
    this.searchSeatBook,
  });

  String? searchStartingPoint;
  String? serchEndPoints;
  String? searchSeatBook;

  factory VehicleTypes.fromJson(Map<String, dynamic> json) => VehicleTypes(
    searchStartingPoint: json["searchStartingPoint"],
    serchEndPoints: json["searchDestinationPoint"],
    searchSeatBook: json["searchSeatBook"],
  );


  Map<String, dynamic> toJson() => {
    "searchStartingPoint": searchStartingPoint,
    "serchEndPoints": serchEndPoints,
    "searchSeatBook": searchSeatBook,
  };

}

