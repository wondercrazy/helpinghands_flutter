// part of '../screens.needs/main_view.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helping_hands/providers/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/firestore_constants.dart';
import '../models/user.dart';
import '../models/vehiclesearch.dart';

class MainProvider with ChangeNotifier {
  String? searchStartingPoint;
  String? searchDestinationPoint;
  String? searchSeatBook;
  var selectedDate1;
  List<VehicleTypes> searchProductList = [];
  List<UserNewModel> tempDataStore = [];
  late VehicleTypes vehicleserch;
  FirebaseFirestore? firebaseFirestore;
  ProfileProvider? profileProvider;
  String id = "";
  final BuildContext context;
  MainProvider(this.context);

  List<VehicleTypes> get getserchVehicleDetails {
    return searchProductList;
  }

  Future<List<VehicleTypes>> fetchVehicleData() async {

    profileProvider = context.read<ProfileProvider>();
    id = profileProvider!.getPrefs(FirestoreConstants.id) ?? "";
    var tempDocData = await FirebaseFirestore.instance
        .collection("users")
        .doc(id) //tempDataStore[0].id.toString()
        .collection("searchHistory")
        .get();
    print(tempDocData.docs.length.toString());
    var tempDatadocuments = tempDocData.docs;
    if (tempDatadocuments != null && tempDatadocuments.length > 0) {
      try {
        searchProductList = tempDatadocuments
            .map((e) => VehicleTypes.fromJson(e.data()))
            .toList();
        return searchProductList;
      } catch (e) {
        print("Exception $e");
        return [];
      }
    }
    return [];
  }

  DateTime selectedDate = DateTime.now();
  String? dateSelected;

  // DateTime selectedDate = DateTime.now();

  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate, // Refer step 1
        firstDate: DateTime.now().subtract(Duration(days: 0)),
        lastDate: DateTime.now().add(Duration(days: 364)));
    if (picked != null && picked != selectedDate)
      // setState(() {
      selectedDate = picked;

    // });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('selectedDate', "$selectedDate");
    // setState(() {
    fetchserchPref;
    // fetchdata(context); // fetchserchPref();
    // });
    notifyListeners();
  }

  addVehicledata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    searchStartingPoint = prefs.getString('searchStartingPoint');
    searchDestinationPoint = prefs.getString('searchDestinationPoint');
    searchSeatBook = prefs.getString('searchSeatBook');
    dateSelected = prefs.getString('selectedDate');

    var value = await FirebaseFirestore.instance
        .collection("${FirestoreConstants.pathUserCollection}")
        .doc("$id")
        .collection("searchHistory")
        .add({
      'searchStartingPoint': "$searchStartingPoint",
      'searchDestinationPoint': "$searchDestinationPoint",
      'searchDate': "${selectedDate == null ? selectedDate1 : selectedDate}",
      'searchSeatBook': "${searchSeatBook == null ? "1" : searchSeatBook}",
    });
    notifyListeners();
  }

  fetchserchPref() async {
    print(searchProductList.length.toString());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    searchStartingPoint = prefs.getString('searchStartingPoint');
    searchDestinationPoint = prefs.getString('searchDestinationPoint');
    searchSeatBook = prefs.getString('searchSeatBook');
    selectedDate1 = prefs.getString('selectedDate');
    notifyListeners();
  }

  Future<void> clearpreference() async {
    print("cleardata");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('searchStartingPoint');
    await preferences.remove('searchDestinationPoint');
    await preferences.remove('searchSeatBook');
    await preferences.remove('selectedDate');
    fetchserchPref();
  }
}
