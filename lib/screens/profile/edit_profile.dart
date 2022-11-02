import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helping_hands/constants/all_constants.dart';
import 'package:helping_hands/models/editprofile.dart';
import 'package:helping_hands/models/user.dart';
import 'package:helping_hands/providers/profile_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../providers/edit_profile_provider.dart';

class EditProfile extends StatefulWidget {
  // String? namee;
  //
  // EditProfile({this.namee});

// EditProfile(this.name);
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  String? username;

  @override
  void initState() {
    super.initState();
    profileProvider = context.read<ProfileProvider>();
    username = profileProvider.getPrefs(FirestoreConstants.name) ?? "";
    // readLocal();
    // addEditProfileData(context);
    // FirebaseFirestore.instance
    //     .collection(FirestoreConstants.pathUserCollection)
    //     .doc(id)
    //     .collection('editProfile')
    //     .doc("eid")
    //     .snapshots()
    //     .listen((QuerySnapshot snapshot) {
    //   firstNameController.text = snapshot.docs.first["name"];
    // });
  }
  // void getgallery(BuildContext context) {
  //   Provider.of<editProfileProvider>(context, listen: false).getFromGallery();
  // }void getFromCameraprovider(BuildContext context) {
  //   Provider.of<editProfileProvider>(context, listen: false).getFromCamera();
  // }

  // void addEditProfileData(BuildContext context) {
  //   Provider.of<editProfileProvider>(context, listen: false).addEditProfile();
  // }
  TextEditingController? displayNameController;

  // TextEditingController? nameController;
  TextEditingController emailController = TextEditingController();

  // TextEditingController? addressController;
  TextEditingController _phoneController = TextEditingController();

  // final controllerName = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  late String currentUserId;

  // String dialCodeDigits = '+00';
  String id = '';

  // String displayName = '';
  // String name = '';
  String photoUrl = '';

  // String phoneNumber = '';
  // String email = '';
  // String address = '';
  // String userstartingpoint = '';

  bool isLoading = false;
  File? avatarImageFile;
  late ProfileProvider profileProvider;

  final FocusNode focusNodeNickname = FocusNode();
  final FocusNode focusNodename = FocusNode();

  // void readLocal() {
  //   setState(() {
  //     id = profileProvider.getPrefs(FirestoreConstants.id) ?? "";
  //     displayName =
  //         profileProvider.getPrefs(FirestoreConstants.displayName) ?? "";
  //     name = profileProvider.getPrefs(FirestoreConstants.name) ?? "";
  //
  //     photoUrl = profileProvider.getPrefs(FirestoreConstants.photoUrl) ?? "";
  //     phoneNumber =
  //         profileProvider.getPrefs(FirestoreConstants.phoneNumber) ?? "";
  //     email = profileProvider.getPrefs(FirestoreConstants.email) ?? "";
  //     address = profileProvider.getPrefs(FirestoreConstants.address) ?? "";
  //   });
  //   displayNameController = TextEditingController(text: displayName);
  //   emailController = TextEditingController(text: email);
  //   nameController = TextEditingController(text: name);
  //   addressController = TextEditingController(text: address);
  // }

  // Future getImage() async {
  //   ImagePicker imagePicker = ImagePicker();
  //   XFile? pickedFile = await imagePicker
  //       .pickImage(source: ImageSource.gallery)
  //       .catchError((onError) {
  //     Fluttertoast.showToast(msg: onError.toString());
  //   });
  //   File? image;
  //   if (pickedFile != null) {
  //     image = File(pickedFile.path);
  //   }
  //   if (image != null) {
  //     setState(() {
  //       avatarImageFile = image;
  //       isLoading = true;
  //     });
  //     uploadFile();
  //   }
  // }

  // Future uploadFile() async {
  //   String fileName = id;
  //   UploadTask uploadTask =
  //       profileProvider.uploadImageFile(avatarImageFile!, fileName);
  //   try {
  //     TaskSnapshot snapshot = await uploadTask;
  //     photoUrl = await snapshot.ref.getDownloadURL();
  //     ChatUser updateInfo = ChatUser(
  //       id: id,
  //       photoUrl: photoUrl,
  //       displayName: displayName,
  //       name: name,
  //       phoneNumber: phoneNumber,
  //       emailAddress: email,
  //       address: address,
  //       userstartingpoint: userstartingpoint,
  //     );
  //     profileProvider
  //         .updateFirestoreData(
  //             FirestoreConstants.pathUserCollection, id, updateInfo.toJson())
  //         .then((value) async {
  //       await profileProvider.setPrefs(FirestoreConstants.photoUrl, photoUrl);
  //       setState(() {
  //         isLoading = false;
  //       });
  //     });
  //   } on FirebaseException catch (e) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     Fluttertoast.showToast(msg: e.toString());
  //   }
  // }

  // void updateFirestoreData() {
  //   focusNodeNickname.unfocus();
  //   setState(() {
  //     isLoading = true;
  //     if (dialCodeDigits != "+00" && _phoneController.text != "") {
  //       phoneNumber = dialCodeDigits + _phoneController.text.toString();
  //     }
  //   });
  //   ChatUser updateInfo = ChatUser(
  //     id: id,
  //     photoUrl: photoUrl,
  //     displayName: displayName,
  //     name: name,
  //     phoneNumber: phoneNumber,
  //     emailAddress: email,
  //     address: address,
  //     userstartingpoint: userstartingpoint,
  //   );
  //   profileProvider
  //       .updateFirestoreData(
  //           FirestoreConstants.pathUserCollection, id, updateInfo.toJson())
  //       .then((value) async {
  //     await profileProvider.setPrefs(
  //         FirestoreConstants.displayName, displayName);
  //     await profileProvider.setPrefs(FirestoreConstants.name, name);
  //     await profileProvider.setPrefs(
  //         FirestoreConstants.phoneNumber, phoneNumber);
  //     await profileProvider.setPrefs(FirestoreConstants.email, email);
  //     await profileProvider.setPrefs(FirestoreConstants.photoUrl, photoUrl);
  //     await profileProvider.setPrefs(FirestoreConstants.emailAddress, email);
  //     await profileProvider.setPrefs(FirestoreConstants.address, address);
  //     setState(() {
  //       isLoading = false;
  //     });
  //     Fluttertoast.showToast(msg: 'UpdateSuccess');
  //     Navigator.pop(context);
  //   }).catchError((onError) {
  //     Fluttertoast.showToast(msg: onError.toString());
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // var read = context.watch<editProfileProvider>();
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text("Edit Profile"),
          backgroundColor: AppColors.white,
          elevation: 0,
          foregroundColor: AppColors.appblue),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: Stack(
            children: [
              SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      GestureDetector(
                        onTap: () { //imagePicker.showDialog(context),
                    showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Wrap(
                        children: [
                          GestureDetector(
                           // onTap:(){read.getFromCamera();},
                            child: ListTile(
                              leading: Icon(Icons.camera_alt),
                              title: Text('Take a picture'),
                            ),
                          ),
                      GestureDetector(
                   //   onTap:(){read.getFromGallery();},
                          child:
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: ListTile(
                              leading: Icon(Icons.image),
                              title: Text('Choose a picture'),
                            ),
                          ),),
                        ],
                      );});},


                        child: Center(
                          child:  avatarImageFile != null
                              ? Stack(
                                  children: <Widget>[
                                    Center(
                                      child: CircleAvatar(
                                        radius: 80.0,
                                        backgroundColor:
                                            const Color(0xFF778899),
                                      ),
                                    ),
                                    // Center(
                                    //   child: Image.asset(
                                    //       "assets/images/covid.png"),
                                    // ),
                                  ],
                                )
                              : Container(
                                  height: 160.0,
                                  width: 160.0,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff7c94b6),
                                    image: DecorationImage(
                                      image://NetworkImage("${read.imageFile}"),
                                           AssetImage("assets/images/covid.png"),

                                      // ExactAssetImage(
                                      //     avatarImageFile!.path),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.all(
                                        const Radius.circular(80.0)),
                                  ),
                                ),
                        ),
                      ),

                      // GestureDetector(
                      //   // onTap: getImage,
                      //   child: Container(
                      //     alignment: Alignment.center,
                      //     child: avatarImageFile == null
                      //         ? photoUrl.isNotEmpty
                      //             ? ClipRRect(
                      //                 borderRadius: BorderRadius.circular(60),
                      //                 child: Image.network(
                      //                   photoUrl,
                      //                   fit: BoxFit.cover,
                      //                   width: 150,
                      //                   height: 150,
                      //                   errorBuilder:
                      //                       (context, object, stackTrace) {
                      //                     return const Icon(
                      //                       Icons.account_circle,
                      //                       size: 150,
                      //                       color: AppColors.greyColor,
                      //                     );
                      //                   },
                      //                   loadingBuilder: (BuildContext context,
                      //                       Widget child,
                      //                       ImageChunkEvent? loadingProgress) {
                      //                     if (loadingProgress == null) {
                      //                       return child;
                      //                     }
                      //                     return SizedBox(
                      //                       width: 150,
                      //                       height: 150,
                      //                       child: Center(
                      //                         child: CircularProgressIndicator(
                      //                           color: AppColors.grey,
                      //                           value: loadingProgress
                      //                                       .expectedTotalBytes !=
                      //                                   null
                      //                               ? loadingProgress
                      //                                       .cumulativeBytesLoaded /
                      //                                   loadingProgress
                      //                                       .expectedTotalBytes!
                      //                               : null,
                      //                         ),
                      //                       ),
                      //                     );
                      //                   },
                      //                 ),
                      //               )
                      //             : const Icon(
                      //                 Icons.account_circle,
                      //                 size: 150,
                      //                 color: AppColors.greyColor,
                      //               )
                      //         : ClipRRect(
                      //             borderRadius: BorderRadius.circular(60),
                      //             child: Image.file(
                      //               avatarImageFile!,
                      //               width: 150,
                      //               height: 150,
                      //               fit: BoxFit.cover,
                      //             ),
                      //           ),
                      //     margin: const EdgeInsets.all(20),
                      //   ),
                      // ),
                      Container(
                        child: FutureBuilder<
                                DocumentSnapshot<Map<String, dynamic>>>(
                            future: FirebaseFirestore.instance
                                .collection('users')
                                .doc("HGw9s6X5WaXffiqQZwGeaZBk1Ow2")
                                .collection('editProfile')
                                .doc("eid")
                                .get(),
                            builder: (_, snapshot) {
                              if (snapshot.hasError) {
                                print('Something Went Wrong');
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              var data = snapshot.data!.data();
                              var namedata = data!['name'];
                              var emaildata = data['email'];
                              var phonenumberdata = data['phonenumber'];
                              var addressdata = data['address'];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Text(
                                    'Name',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.spaceCadet,
                                    ),
                                  ),
                                  TextFormField(
                                    initialValue: namedata,
                                    // controller: firstNameController,
                                    //controllerName,
                                    //nameController,
                                    decoration: kTextInputDecoration.copyWith(
                                        hintText: 'Enter Name'),
                                    onChanged: (value) {
                                      namedata = value;
                                    },
                                    focusNode: focusNodename,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter Name';
                                      }
                                      return null;
                                    },
                                  ),
                                  vertical15,
                                  const Text(
                                    'Email',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.spaceCadet),
                                  ),
                                  TextFormField(
                                    initialValue: emaildata,
                                    // controller: emailController,
                                    // readOnly: true,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: kTextInputDecoration.copyWith(
                                        hintText: 'Enter Email'),
                                    onChanged: (value) {
                                      emaildata = value;
                                      // validateEmail(value);
                                    },
                                  ),
                                  // vertical15,
                                  // const Text(
                                  //   'Select Country Code',
                                  //   style: TextStyle(
                                  //     fontStyle: FontStyle.italic,
                                  //     fontWeight: FontWeight.bold,
                                  //     color: AppColors.spaceCadet,
                                  //   ),
                                  // ),
                                  // Container(
                                  //   width: double.infinity,
                                  //   alignment: Alignment.centerLeft,
                                  //   decoration: BoxDecoration(
                                  //     border: Border.all(
                                  //         color: AppColors.black, width: 1.5),
                                  //     borderRadius: BorderRadius.circular(10),
                                  //   ),
                                  //   child: CountryCodePicker(
                                  //     onChanged: (country) {
                                  //       setState(() {
                                  //         dialCodeDigits = country.dialCode!;
                                  //       });
                                  //     },
                                  //     initialSelection: 'IN',
                                  //     showCountryOnly: false,
                                  //     showOnlyCountryWhenClosed: false,
                                  //     favorite: const ["+91", "IN"], //"+1", "US",
                                  //   ),
                                  // ),
                                  vertical10,
                                  const Text(
                                    'Phone Number',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.spaceCadet,
                                    ),
                                  ),
                                  TextFormField(
                                    initialValue: phonenumberdata,
                                    // controller: _phoneController,
                                    decoration: kTextInputDecoration.copyWith(
                                      hintText: 'Mobile Number',
                                    ),
                                    //   prefix: Padding(
                                    //     padding: const EdgeInsets.all(4),
                                    //     child: Text(
                                    //       dialCodeDigits,
                                    //       style:
                                    //           const TextStyle(color: AppColors.black),
                                    //     ),
                                    //   ),
                                    // ),
                                    onChanged: (value) {
                                      phonenumberdata = value;
                                    },
                                    maxLength: 10,
                                    //dialCodeDigits == "+91" ? 10 : 12,
                                    keyboardType: TextInputType.number,
                                  ),
                                  vertical10,
                                  const Text(
                                    'Address',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.spaceCadet),
                                  ),
                                  TextFormField(
                                    initialValue: addressdata,
                                    // controller: addressController,
                                    decoration: kTextInputDecoration.copyWith(
                                        hintText: 'Enter Address'),
                                    onChanged: (value) {
                                      addressdata = value;
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter address';
                                      }
                                      return null;
                                    },
                                  ),
                                  vertical15,
                                  ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          // updateFirestoreData();
                                          updateEditProfile(namedata, emaildata,
                                              phonenumberdata, addressdata);
                                          // final edituser = EditProfiles(
                                          //     name: firstNameController.text,
                                          //     address: addressController.text,
                                          //     email: emailController.text,
                                          //     phonenumber: _phoneController.text);
                                          // addEditProfile(edituser);
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.all(14.0),
                                        child: Text('Update Info'),
                                      )),
                                ],
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  child: isLoading
                      ? Container(
                          color: AppColors.black,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.lightGrey,
                            ),
                          ),
                        ) //LoadingView()
                      : const SizedBox.shrink()),
            ],
          ),
        ),
      ),
    );
  }

  void addEditProfile(EditProfiles edituser) async {
    profileProvider = context.read<ProfileProvider>();
    id = profileProvider.getPrefs(FirestoreConstants.id) ?? "";

    var collection = FirebaseFirestore.instance
        .collection(FirestoreConstants.pathUserCollection);
    collection.doc(id).collection("editProfile").doc();
    await collection
        .doc(id)
        .collection('editProfile')
        .doc("eid")
        .set(edituser.toJson());
  }

  Future<void> updateEditProfile(name, email, phonenumber, address) async {
    profileProvider = context.read<ProfileProvider>();
    id = profileProvider.getPrefs(FirestoreConstants.id) ?? "";

    var collection = FirebaseFirestore.instance
        .collection(FirestoreConstants.pathUserCollection);
    collection.doc(id).collection("editProfile").doc();
    return collection
        .doc(id)
        .collection('editProfile')
        .doc("eid")
        .update({
          'name': name,
          'email': email,
          'phonenumber': phonenumber,
          'address': address,

        })
        .then((value) => print("update successfully"))
        .catchError((error) => print("failed update user $error"));
    // .set(edituser.toJson());
  }
// Stream<List<EditProfiles>> readEditProfileData() => FirebaseFirestore.instance
//     .collection(FirestoreConstants.pathUserCollection)
//     .doc(id)
//     .collection("editProfile")
//     .snapshots()
//     .map((snapshot) => snapshot.docs
//         .map((doc) => EditProfiles.fromJson(doc.data()))
//         .toList());
}
