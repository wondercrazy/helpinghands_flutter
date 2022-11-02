import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:helping_hands/constants/firestore_constants.dart';
import 'package:helping_hands/providers/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchVehicleProvider extends ChangeNotifier {
  final BuildContext context;
  var searchStartingPoint;
  var searchDestinationPoint;
  var searchSeatBook;
  var selectedDate;
  DateTime selectedDate1 = DateTime.now();
  ProfileProvider? profileProvider;

  SearchVehicleProvider(this.context);

  addVehicledata() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    searchStartingPoint = prefs.getString('searchStartingPoint');
    searchDestinationPoint = prefs.getString('searchDestinationPoint');
    searchSeatBook = prefs.getString('searchSeatBook');
    selectedDate = prefs.getString('selectedDate');
    String id = "";
    // List<SearchVehicleModel> newList = [];
    profileProvider = context.read<ProfileProvider>();
    id = profileProvider!.getPrefs(FirestoreConstants.id) ?? "";
    var value = await FirebaseFirestore.instance
        .collection("${FirestoreConstants.pathUserCollection}")
        .doc(id)
        .collection("searchHistory")
        .add({
      'searchStartingPoint': "$searchStartingPoint",
      'searchDestinationPoint': "$searchDestinationPoint",
      'searchDate': "${selectedDate == null ? selectedDate1 : selectedDate}",
      'searchSeatBook': "${searchSeatBook == null ? "1" : searchSeatBook}",
    });
    notifyListeners();
  }
}
