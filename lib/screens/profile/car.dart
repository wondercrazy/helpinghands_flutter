import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helping_hands/providers/addvehicle_provider.dart';
import 'package:provider/provider.dart';
import '../../constants/color_constants.dart';
import '../../providers/profile_provider.dart';
import 'add_car.dart';

class CarAddData extends StatefulWidget {
  const CarAddData({Key? key}) : super(key: key);

  @override
  State<CarAddData> createState() => _CarAddDataState();
}

class _CarAddDataState extends State<CarAddData> {
  late ProfileProvider profileProvider;
  @override
  void initState() {
    super.initState();
    Provider.of<AddVehicleProvider>(context,listen: false).readLocal();
    profileProvider = context.read<ProfileProvider>();
  }


  @override
  Widget build(BuildContext context) {
    var read =context.watch<AddVehicleProvider>();
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,

          actions: <Widget>[
            FlatButton(
              textColor: AppColors.white,
              onPressed: () {},
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddCarLicensePlate(),
                    ));
                  },
                  child: Text(
                    "ADD VEHICLE",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )),
              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            ),
          ],
          backgroundColor: AppColors.white,
          elevation: 0,
          foregroundColor: AppColors.appblue),
      body: read.doclenth == null
          ? Center(
              child: Text(
              "Please add vehicle",
              style: TextStyle(fontSize: 20),
            ))
          : SafeArea(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: read.doclenth ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Card(
                                    semanticContainer: true,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: Container(
                                      height: 200,
                                      width: MediaQuery.of(context).size.width,
                                      child: Image.network(
                                        "${read.getuservehicleImageURL[index] ?? ""} ",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    elevation: 5,
                                    margin: EdgeInsets.all(10),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Text(
                                            "${read.getuservehicleBrandName[index] ?? ""} ",
                                            //  "Tata ",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: AppColors.black54,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Text(
                                          "${read.getuservehicleBrandModel[index] ?? ""} ",
                                          // "Tigor ",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: AppColors.black54,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: Text(
                                            "${read.getuservehicleyear[index] ?? ""}",
                                            //"2022",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: AppColors.black54,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, top: 10),
                                    child: Text(
                                      "${read.getuservehiclecolor[index] ?? ""}",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: AppColors.black54,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () async {
                                            read.clearpreference();
                                            var collection = FirebaseFirestore
                                                .instance
                                                .collection('users');
                                            await collection
                                                .doc("HGw9s6X5WaXffiqQZwGeaZBk1Ow2")
                                                .collection("vehicle")
                                                .get()
                                                .then((docs) {
                                              if (docs.docs.isNotEmpty) {
                                                collection
                                                    .doc('HGw9s6X5WaXffiqQZwGeaZBk1Ow2')
                                                    .collection("vehicle")
                                                    .doc(
                                                        "${docs.docs[index].id}")
                                                    .delete()
                                                    .then(
                                                        (_) => print('Deleted'))
                                                    .catchError((error) => print(
                                                        'Delete failed: $error'));
                                                read.readLocal();
                                              }
                                            });
                                          },
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 5),
                                                child: Icon(
                                                  Icons.delete,
                                                  size: 15,
                                                ),
                                              ),
                                              Text("Delete"),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
