// import 'dart:convert';
// import 'package:flutter/material.dart';
// class CarsModel {
//   late List<Brand> brand;
//
//   CarsModel({ required this.brand});
//   CarsModel.fromJSON(Map<String, dynamic> json) {
//     brand = json['brand'].map<Brand>((json) => Brand.fromJSON(json)).toList();
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//
//     data['brand'] = this.brand;
//     return data;
//   }
// }
// // Brand BrandFromJson(String str) => Brand.fromJSON(json.decode(str));
// //
// // String BrandToJson(Brand data) => json.encode(data.toJson());
// class Brand {
//   late String name;
//   late String category;
//   late String model;
//
//   Brand({required this.name, required this.category, required this.model});
//
//   Brand.fromJSON(Map<String, dynamic> json) {
//     name = json['name'].toString();
//     category = json['category'].toString();
//     model = json['model'].toString();
// }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['name'] = this.name;
//     data['category'] = this.category;
//     data['model'] = this.model;
//
//     return data;
//   }
// }