import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helping_hands/providers/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/firestore_constants.dart';
import '../models/addcarride.dart';
import '../models/vehiclesearch.dart';

class AddCarProvider with ChangeNotifier {
  ProfileProvider? profileProvider;
  String id = "";
  List<AddCarRideModel> searchDriverList = [];
  List<VehicleTypes> searchList = [];
  late AddCarRideModel driverRideSearch;
  late VehicleTypes Search;
  List<String>? driverStartingPoint=[];
  List<String>  driverDestinationPoint=[];
  final BuildContext context;

  AddCarProvider(this.context);

  fetchAndAddDriverPrefData() async {
    profileProvider = context.read<ProfileProvider>();
    id = profileProvider!.getPrefs(FirestoreConstants.id) ?? "";

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? driverStartingPoint = prefs.getString('driverStartingPoint');
    String? driverDestinationPoint = prefs.getString('driverDestinationPoint');
    String? selectedDropDownNumberPlate = prefs.getString('selectedDropDownNumberPlate');
    String? driverGoingToDate = prefs.getString('driverGoingToDate');
    String? driverPickTime = prefs.getString('driverPickTime');
    String? driverAboutRide = prefs.getString('driverAboutRide');

    var collection = FirebaseFirestore.instance
        .collection(FirestoreConstants.pathUserCollection);
    collection.doc(id).collection("driver").add({
      'driverStartingPoint': "$driverStartingPoint",
      'driverDestinationPoint': "$driverDestinationPoint",
      'selectedDropDownNumberPlate':"$selectedDropDownNumberPlate",
      'driverGoingToDate': "$driverGoingToDate",
      'driverPickTime': "$driverPickTime",
      'driverAboutRide': "$driverAboutRide",
    });
    notifyListeners();
  }

  // Future<QuerySnapshot<Object?>> q;

      // driverGoingToDate,
      // driverPickTime,
      // driverAboutRide;
  Future<void> getDriverAllData() async {
    var query = await FirebaseFirestore.instance.collection("users").get();
    List<AddCarRideModel> newList = [];
    profileProvider = context.read<ProfileProvider>();
    id = profileProvider!.getPrefs(FirestoreConstants.id) ?? "";
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("driver")
        .get();

    for (var element in value.docs) {
      // value.docs.map((element) {
      // print("driver element :: ${element.data()}");
      driverRideSearch = AddCarRideModel(
          driverStartingPoint: element.get("driverStartingPoint"),
          driverDestinationPoint: element.get("driverDestinationPoint"),
          driverGoingToDate: element.get("driverGoingToDate"),
          driverPickTime: element.get("driverPickTime"),
          driverAboutRide: element.get("driverAboutRide"));

      newList.add(driverRideSearch);
      // newList.map((e) {
      driverStartingPoint = [];
      driverDestinationPoint = [];
      for (var element in newList) {
        driverStartingPoint!.add("\"${element.driverStartingPoint}\"");
        driverDestinationPoint.add("\"${element.driverDestinationPoint}\"");
        // driverGoingToDate = element.driverGoingToDate;
        // driverPickTime = element.driverPickTime;
        // driverAboutRide = element.driverAboutRide;
      };
      searchDriverList = newList;
      notifyListeners();
    };
  }


    List<String> searchStartingPoint=[];
    List? serchEndPoints=[];
    Future<void> getSearchAllData() async {
      var query = await FirebaseFirestore.instance.collection("users").get();
      List<VehicleTypes> newList1 = [];
      profileProvider = context.read<ProfileProvider>();
      id = profileProvider!.getPrefs(FirestoreConstants.id) ?? "";
      QuerySnapshot serchValue = await FirebaseFirestore.instance
          .collection("users")
          .doc(id)
          .collection("searchHistory")
          .get();

      for (var element in serchValue.docs) {
        // value.docs.map((element) {
        // print("driver element :: ${element.data()}");
        Search = VehicleTypes(
          searchStartingPoint: element.get("searchStartingPoint"),
          serchEndPoints: element.get("searchDestinationPoint"),
          searchSeatBook: element.get("searchSeatBook"),
        );

        newList1.add(Search);
        // newList.map((e) {
        searchStartingPoint = [];
        serchEndPoints = [];
        for (var element in newList1) {
          //print(element.searchStartingPoint.runtimeType);
          searchStartingPoint.add("\"${element.searchStartingPoint}\"");
          print("LIST ::searchStartingPoint");
          // print('"[\'' + searchStartingPoint.join("', '") + '\']"';

          serchEndPoints!.add(element.serchEndPoints);
          // driverGoingToDate = element.driverGoingToDate;
          // driverPickTime = element.driverPickTime;
          // driverAboutRide = element.driverAboutRide;
        };
        print("searchStartingPoint-----------: $searchStartingPoint");
        searchList = newList1;
        notifyListeners();
      };
      List<String> badWords = ["Surat"];
      List<String> sentences = [
        "Surat, Gujarat, India",
          "Pune, Maharashtra, India",
          "Chalthan, Surat, Gujarat, India",
          "Pal, Surat, Gujarat, India",
          "Gujarat Gas Circle, Muktanand Nagar, Narotam Nagar, Surat, Gujarat, India"
      ];


        for (String sentence in searchStartingPoint) {
          if (isSentenceOffensive(sentence, badWords)) {
            print('$sentence');

          }
        }
      }

      bool isSentenceOffensive(String sentence, List<String> badWords) {
        List<String> words = sentence.split(RegExp(r"[., ]"));
        for (String word in words) {
          if (badWords.contains(word)) {
            return true;
          }
        }
        return false;
      }

      // List<String> badWords = ["Surat","India"];
      // List<String> sentences = [
      //   "Surat, Gujarat, India",
      //   "Pune, Maharashtra, India",
      //   "Chalthan, Surat, Gujarat, India",
      //   "Pal, Surat, Gujarat, India",
      //   "Gujarat Gas Circle, Muktanand Nagar, Narotam Nagar, Surat, Gujarat, India"
      // ];
      // for (String sentence in sentences) {
      //   if (isSentenceOffensive(sentence, badWords)) {
      //     print('sentance first :----$sentence');
      //   }
      // }
    //   List<String> addeditem = [];
    //   for (int i = 0; i < searchStartingPoint.length; i++) {
    //     for (String sentence in searchStartingPoint) {
    //       if (isSentenceOffensive(sentence, driverStartingPoint![i])) {
    //         addeditem=[];
    //         addeditem.add(" $sentence ");
    //       }
    //       print("addeditem ==== $addeditem");
    //     }
    //   }
    // }
  // bool isSentenceOffensive(String sentence, badWords) {
  //   List<String> words = sentence.split(RegExp(r"[., ]"));
  //   for (String word in words) {
  //     if (badWords.contains(word)) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

}

// List<AddCarRideModel> newList = [];
//  Future<List<AddCarRideModel>> getAllData()async
// {
//
//   List<AddCarRideModel> allPosts = [];
//   var query= await FirebaseFirestore.instance.collection("users").get();
//   for(var userdoc in query.docs)
//   {
//       QuerySnapshot feed = await FirebaseFirestore.instance.collection("users")
//         .doc(userdoc.id).collection("driver").get();
//     // for (var postDoc in feed.docs) {
//     //  // var post = AddCarRideModel.fromJson(postDoc);
//     //  //  allPosts.add(post);
//     //   // feed.docs.map((element) {
//     //         print("driver element ------:: ${postDoc.toString()}");
//     //
//     //         driverRideSearch = AddCarRideModel(
//     //             driverStartingPoint: postDoc.get("driverStartingPoint"),
//     //             driverDestinationPoint: postDoc.get("driverDestinationPoint"),
//     //             driverGoingToDate: postDoc.get("driverGoingToDate"),
//     //             driverPickTime: postDoc.get("driverPickTime"),
//     //             driverAboutRide: postDoc.get("driverAboutRide"));
//     //
//     //         newList.add(driverRideSearch);
//     //         searchDriverList = newList;
//     //
//     //         print("---------------- :}");
//     //         notifyListeners();
//     //       // });
//     // }
//       for (var element in feed.docs) {
//       // feed.docs.map((element) {
//             print("driver element :: ${element.data()}");
//             driverRideSearch = AddCarRideModel(
//                 driverStartingPoint: element.get("driverStartingPoint"),
//                 driverDestinationPoint: element.get("driverDestinationPoint"),
//                 driverGoingToDate: element.get("driverGoingToDate"),
//                 driverPickTime: element.get("driverPickTime"),
//                 driverAboutRide: element.get("driverAboutRide"));
//
//             newList.add(driverRideSearch);
//             searchDriverList = newList;
//             notifyListeners();
//           };
//   }
//   return allPosts;
// }


