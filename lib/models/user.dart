import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:helping_hands/constants/all_constants.dart';

class ChatUser extends Equatable {
  final String id;
  final String photoUrl;
  final String displayName;
  final String name;
  final String phoneNumber;
  final String emailAddress;
  final String address;
  final String userstartingpoint;

  const ChatUser({
    required this.id,
    required this.photoUrl,
    required this.displayName,
    required this.name,
    required this.phoneNumber,
    required this.emailAddress,
    required this.address,
    required this.userstartingpoint,
  });

  ChatUser copyWith({
    String? id,
    String? photoUrl,
    String? nickname,
    String? nameofuser,
    String? phoneNumber,
    String? email,
    String? addr,
    String? usersearchstartingpoint,
  }) =>
      ChatUser(
        id: id ?? this.id,
        photoUrl: photoUrl ?? this.photoUrl,
        displayName: nickname ?? displayName,
        name: nickname ?? name,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        emailAddress: email ?? emailAddress,
        address: addr ?? address,
        userstartingpoint: usersearchstartingpoint ?? userstartingpoint,
      );

  Map<String, dynamic> toJson() => {
        FirestoreConstants.displayName: displayName,
        FirestoreConstants.name: name,
        FirestoreConstants.photoUrl: photoUrl,
        FirestoreConstants.phoneNumber: phoneNumber,
        FirestoreConstants.emailAddress: emailAddress,
        FirestoreConstants.address: address,
        FirestoreConstants.userstartingpoint: userstartingpoint,
      };
  factory ChatUser.fromDocument(DocumentSnapshot snapshot) {
    String photoUrl = "";
    String nickname = "";
    String nameofuser ="";
    String phoneNumber = "";
    String email = "";
    String addr = "";
    String usersearchstartingpoint = "";

    try {
      photoUrl = snapshot.get(FirestoreConstants.photoUrl);
      nickname = snapshot.get(FirestoreConstants.displayName);
      nameofuser = snapshot.get(FirestoreConstants.name);
      phoneNumber = snapshot.get(FirestoreConstants.phoneNumber);
      email = snapshot.get(FirestoreConstants.emailAddress);
      addr = snapshot.get(FirestoreConstants.address);
      usersearchstartingpoint = snapshot.get(FirestoreConstants.userstartingpoint);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return ChatUser(
      id: snapshot.id,
      photoUrl: photoUrl,
      displayName: nickname,
      name: nameofuser,
      phoneNumber: phoneNumber,
      emailAddress: email,
      address: addr,
      userstartingpoint: usersearchstartingpoint,
    );
  }
  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, photoUrl, displayName, name, phoneNumber, emailAddress, address,userstartingpoint];
}


UserNewModel userNewModelFromJson(String str) => UserNewModel.fromJson(json.decode(str));

String userNewModelToJson(UserNewModel data) => json.encode(data.toJson());

class UserNewModel {
  UserNewModel({
    this.displayName,
    this.email,
    this.id,
    this.photoUrl,
  });

  String? displayName;
  String? email;
  String? id;
  String? photoUrl;

  factory UserNewModel.fromJson(Map<String, dynamic> json) => UserNewModel(
    displayName: json["displayName"],
    email: json["email"],
    id: json["id"],
    photoUrl: json["photoUrl"],
  );

  Map<String, dynamic> toJson() => {
    "displayName": displayName,
    "email": email,
    "id": id,
    "photoUrl": photoUrl,
  };
}




// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/foundation.dart';
// import 'package:helping_hands/constants/all_constants.dart';
//
// class ChatUser extends Equatable {
//   final String id;
//   final String photoUrl;
//   final String displayName;
//   final String phoneNumber;
//   final String aboutMe;
//
//   const ChatUser(
//       {required this.id,
//         required this.photoUrl,
//         required this.displayName,
//         required this.phoneNumber,
//         required this.aboutMe});
//
//   ChatUser copyWith({
//     String? id,
//     String? photoUrl,
//     String? nickname,
//     String? phoneNumber,
//     String? email,
//   }) =>
//       ChatUser(
//           id: id ?? this.id,
//           photoUrl: photoUrl ?? this.photoUrl,
//           displayName: nickname ?? displayName,
//           phoneNumber: phoneNumber ?? this.phoneNumber,
//           aboutMe: email ?? aboutMe);
//
//   Map<String, dynamic> toJson() => {
//     FirestoreConstants.displayName: displayName,
//     FirestoreConstants.photoUrl: photoUrl,
//     FirestoreConstants.phoneNumber: phoneNumber,
//     FirestoreConstants.aboutMe: aboutMe,
//   };
//   factory ChatUser.fromDocument(DocumentSnapshot snapshot) {
//     String photoUrl = "";
//     String nickname = "";
//     String phoneNumber = "";
//     String aboutMe = "";
//
//     try {
//       photoUrl = snapshot.get(FirestoreConstants.photoUrl);
//       nickname = snapshot.get(FirestoreConstants.displayName);
//       phoneNumber = snapshot.get(FirestoreConstants.phoneNumber);
//       aboutMe = snapshot.get(FirestoreConstants.aboutMe);
//     } catch (e) {
//       if (kDebugMode) {
//         print(e);
//       }
//     }
//     return ChatUser(
//         id: snapshot.id,
//         photoUrl: photoUrl,
//         displayName: nickname,
//         phoneNumber: phoneNumber,
//         aboutMe: aboutMe);
//   }
//   @override
//   // TODO: implement props
//   List<Object?> get props => [id, photoUrl, displayName, phoneNumber, aboutMe];
// }