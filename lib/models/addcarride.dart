import 'dart:convert';

AddCarRideModel addCarModelFromJson(String str) => AddCarRideModel.fromJson(json.decode(str));

String addCarModelToJson(AddCarRideModel data) => json.encode(data.toJson());

class AddCarRideModel {
  AddCarRideModel({
    this.driverStartingPoint,
    this.driverDestinationPoint,
    this.driverGoingToDate,
    this.driverPickTime,
    this.driverAboutRide,
  });

  String? driverStartingPoint;
  String? driverDestinationPoint;
  String? driverGoingToDate;
  String? driverPickTime;
  String? driverAboutRide;

  factory AddCarRideModel.fromJson(Map<String, dynamic> json) => AddCarRideModel(
    driverStartingPoint: json["driverStartingPoint"],
    driverDestinationPoint: json["driverDestinationPoint"],
    driverGoingToDate: json["driverGoingToDate"],
    driverPickTime: json["driverPickTime"],
    driverAboutRide: json["driverAboutRide"],
  );

  Map<String, dynamic> toJson() => {
    "driverStartingPoint": driverStartingPoint,
    "driverDestinationPoint": driverDestinationPoint,
    "driverGoingToDate": driverGoingToDate,
    "driverPickTime": driverPickTime,
    "driverAboutRide": driverAboutRide,
  };
}