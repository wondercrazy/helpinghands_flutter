import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:helping_hands/providers/profile_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../constants/firestore_constants.dart';
import '../models/editprofile.dart';

class editProfileProvider extends ChangeNotifier {
  ProfileProvider? profileProvider;
  String id = "";
  final BuildContext context;
  File? imageFile;
  editProfileProvider(this.context);

  addEditProfile(EditProfiles editProfiledata) async {
    profileProvider = context.read<ProfileProvider>();
    id = profileProvider!.getPrefs(FirestoreConstants.id) ?? "";

    var collection = FirebaseFirestore.instance
        .collection(FirestoreConstants.pathUserCollection);
    collection.doc(id).collection("editProfile").doc();
    // add({
    //   'Name':"username",
    //   'ImageURL': "uploadedFileURL",
    // });.collection('editProfile').doc("eid").update(editProfiledata.toJson());
    // EditProfiles editProfiledata = EditProfiles(
    //   name: "name",
    //   // email: "email",
    //   // address: "ad",
    //   // image: "image",
    // );
    await collection
        .doc(id)
        .collection('editProfile')
        .doc("eid")
        .set(editProfiledata.toJson());
  notifyListeners();
  }
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
}
