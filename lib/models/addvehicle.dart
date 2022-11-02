import 'dart:convert';

AddCarModel addCarModelFromJson(String str) => AddCarModel.fromJson(json.decode(str));

String addCarModelToJson(AddCarModel data) => json.encode(data.toJson());

class AddCarModel {
  AddCarModel({
    this.vehicleCountryName,
    this.vehicleLicensePlateNumber,
    this.vehicleBrandName,
    this.vehicleBrandCategory,
    this.vehicleBrandModel,
    this.vehiclecolor,
    this.vehicleYear,
  });

  String? vehicleCountryName;
  String? vehicleLicensePlateNumber;
  String? vehicleBrandName;
  String? vehicleBrandCategory;
  String? vehicleBrandModel;
  String? vehiclecolor;
  String? vehicleYear;

  factory AddCarModel.fromJson(Map<String, dynamic> json) => AddCarModel(
    vehicleCountryName: json["vehicleCountryName"],
    vehicleLicensePlateNumber: json["vehicleLicensePlateNumber"],
    vehicleBrandName: json["vehicleBrandName"],
    vehicleBrandCategory: json["vehicleBrandCategory"],
    vehicleBrandModel: json["vehicleBrandModel"],
    vehiclecolor: json["vehiclecolor"],
    vehicleYear: json["vehicleYear"],
  );

  Map<String, dynamic> toJson() => {
    "vehicleCountryName": vehicleCountryName,
    "vehicleLicensePlateNumber": vehicleLicensePlateNumber,
    "vehicleBrandName": vehicleBrandName,
    "vehicleBrandCategory": vehicleBrandCategory,
    "vehicleBrandModel": vehicleBrandModel,
    "vehiclecolor": vehiclecolor,
    "vehicleYear": vehicleYear,
  };
}
