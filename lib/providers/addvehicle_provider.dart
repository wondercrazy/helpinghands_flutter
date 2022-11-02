import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helping_hands/providers/addcarride_provider.dart';
import 'package:helping_hands/providers/profile_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/firestore_constants.dart';

class AddVehicleProvider extends ChangeNotifier {
  ProfileProvider? profileProvider;
  String id = "";
  var doclenth;
  var getuservehicleImageURL = [];
  var getuservehicleBrandName = [];
  var getuservehicleBrandCategory = [];
  var getuservehicleBrandModel = [];
  var getuservehiclecolor = [];
  var vehicleLicensePlateNumber = [];
  var getuservehicleyear = [];
  File? imageFile;
  String? uploadedFileURL;

  final BuildContext context;

  AddVehicleProvider(this.context);

  // @override
  // void initState() {
  //
  //   profileProvider = context.read<ProfileProvider>();
  //   id = profileProvider!.getPrefs(FirestoreConstants.id) ?? "";
  //   super.initState();
  // }





  getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      notifyListeners();
    }
  }

  getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      notifyListeners();
    }
  }

  selectImage() async {
    Fluttertoast.showToast(
        msg: "Please wait...",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.blue.shade500,
        textColor: Colors.white,
        fontSize: 16.0);
    try {
      final storageRef = await FirebaseStorage.instance
          .ref()
          .child("usercaraddphoto/$imageFile");
      await storageRef.putFile(imageFile!);

      storageRef.getDownloadURL().then((fileURL) {
        uploadedFileURL = fileURL;

        addCar();
        notifyListeners();
      });
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  addCar() async {
    profileProvider = context.read<ProfileProvider>();
    id = profileProvider!.getPrefs(FirestoreConstants.id) ?? "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? vehicleCountryName = prefs.getString('vehicleCountryName');
    String? vehicleLicensePlateNumber =
        prefs.getString('vehicleLicensePlateNumber');
    String? vehicleBrandName = prefs.getString('vehicleBrandName');
    String? vehicleBrandCategory = prefs.getString('vehicleBrandCategory');
    String? vehicleBrandModel = prefs.getString('vehicleBrandModel');
    String? vehiclecolor = prefs.getString('vehiclecolor');
    String? vehicleYear = prefs.getString('vehicleYear');
    String? vehicleImage = prefs.getString('vehicleImage');
    var collection = FirebaseFirestore.instance
        .collection(FirestoreConstants.pathUserCollection);
    collection.doc(id).collection("vehicle").add({
      'vehicleCountryName': "$vehicleCountryName",
      'vehicleLicensePlateNumber': "$vehicleLicensePlateNumber",
      'vehicleBrandName': "$vehicleBrandName",
      'vehicleBrandCategory': "$vehicleBrandCategory",
      'vehicleBrandModel': "$vehicleBrandModel",
      'vehiclecolor': "$vehiclecolor",
      'vehicleYear': "$vehicleYear",
      'ImageURL': "$uploadedFileURL",
    });
    clearpreference();
  }

  void readLocal() async {
    profileProvider = context.read<ProfileProvider>();
    id = profileProvider!.getPrefs(FirestoreConstants.id) ?? "";
    var collection = FirebaseFirestore.instance.collection('users');
    await collection
        .doc(id)
        .collection("vehicle")
        .get()
        .then((docs) {
      vehicleLicensePlateNumber=[];
      if (docs.docs.isNotEmpty) {
        for (int i = 0; i < docs.docs.length; i++) {
          doclenth = docs.docs.length;
          getuservehicleImageURL.add(docs.docs[i].data()['ImageURL']);
          getuservehicleBrandName.add(docs.docs[i].data()['vehicleBrandName']);
          getuservehicleBrandCategory
              .add(docs.docs[i].data()['vehicleBrandCategory']);
          getuservehicleBrandModel
              .add(docs.docs[i].data()['vehicleBrandModel']);
          getuservehiclecolor.add(docs.docs[i].data()['vehiclecolor']);
          vehicleLicensePlateNumber.add(docs.docs[i].data()['vehicleLicensePlateNumber']);
          getuservehicleyear.add(docs.docs[i].data()['vehicleYear']);
          notifyListeners();
        }
      }
    });
  }

  clearpreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('vehicleCountryName');
    await preferences.remove('vehicleLicensePlateNumber');
    await preferences.remove('vehicleBrandName');
    await preferences.remove('vehicleBrandCategory');
    await preferences.remove('vehicleBrandModel');
    await preferences.remove('vehiclecolor');
    await preferences.remove('vehicleYear');
    imageFile = null; //File("");
    uploadedFileURL = null;
    doclenth = null;
    getuservehicleImageURL = [];
    getuservehicleBrandName = [];
    getuservehicleBrandCategory = [];
    getuservehicleBrandModel = [];
    getuservehiclecolor = [];
    getuservehicleyear = [];
    vehicleLicensePlateNumber=[];
  }
}
