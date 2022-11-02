import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../constants/color_constants.dart';
import '../../providers/addvehicle_provider.dart';

class UploadCarImage extends StatefulWidget {
  const UploadCarImage({Key? key}) : super(key: key);

  @override
  State<UploadCarImage> createState() => _UploadCarImageState();
}

class _UploadCarImageState extends State<UploadCarImage> {
  // var read;
  @override
  void initState() {
    super.initState();
  }

  void getgallery(BuildContext context) {
    Provider.of<AddVehicleProvider>(context, listen: false).getFromGallery();
  }void getFromCameraprovider(BuildContext context) {
    Provider.of<AddVehicleProvider>(context, listen: false).getFromCamera();
  }

  @override
  Widget build(BuildContext context) {
    var read = context.watch<AddVehicleProvider>();
    return Scaffold(
      floatingActionButton: (read.imageFile == null)
          ? FloatingActionButton.extended(
              backgroundColor: AppColors.grey,
              onPressed: () {
                Fluttertoast.showToast(
                    msg: "Please pick image",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: AppColors.red,
                    textColor: AppColors.white,
                    fontSize: 16.0);
              },
              label: Text(
                'Save',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            )
          : FloatingActionButton.extended(
              onPressed: () {
                read.selectImage();
                 Navigator.pushNamed(context, "/home");
              },
              label: Text(
                'Save',
                style: TextStyle(fontSize: 17),
              ),
            ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: GestureDetector(
            onTap: () {},
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                      child:
                          Icon(Icons.arrow_back, size: 30, color: AppColors.appblue),
                      onTap: () {
                        Navigator.pop(context);
                      }),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 30, bottom: 40),
                    child: Text(
                      "Take your vehicle image",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  (read.imageFile == null && read.uploadedFileURL == null)
                      ? Container(
                          height: 400,
                          width: 500,
                          color: AppColors.greyshade300,
                          child: Center(child: Text("No image selected")),
                        )
                      : Container(
                          height: 400,
                          width: 500,
                          child: Image.file(
                            read.imageFile!,
                            fit: BoxFit.cover,
                          ),
                        ),
                  ( read.uploadedFileURL != null && read.imageFile != null)
                      ? Container(
                          margin: EdgeInsets.only(top: 20, bottom: 50),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: RaisedButton(
                                  color: AppColors.grey,
                                  onPressed: () {},
                                  child:
                                      Center(child: Text("PICK FROM GALLERY")),
                                ),
                              ),
                              Container(
                                width: 20.0,
                              ),
                              Expanded(
                                child: RaisedButton(
                                  color: AppColors.grey,
                                  onPressed: () {},
                                  child: Center(
                                    child: Text(
                                      "PICK FROM CAMERA",
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.only(top: 20, bottom: 50),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: RaisedButton(
                                  color: AppColors.redshade200,
                                  onPressed: () {
                                     getgallery(context);
                                  },
                                  child:
                                      Center(child: Text("PICK FROM GALLERY")),
                                ),
                              ),
                              Container(
                                width: 20.0,
                              ),
                              Expanded(
                                child: RaisedButton(
                                  color: AppColors.greenshade100,
                                  onPressed: () {
                                    // temp?.getFromCamera();
                                    getFromCameraprovider(context);
                                    // addPrefvehicleImage();
                                  },
                                  child: Center(
                                    child: Text(
                                      "PICK FROM CAMERA",
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
