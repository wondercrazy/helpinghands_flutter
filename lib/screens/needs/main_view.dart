import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:helping_hands/constants/all_constants.dart';
import 'package:helping_hands/screens/needs/search_rides.dart';
import 'package:helping_hands/screens/needs/serch_start_point.dart';
import 'package:helping_hands/screens/numberofseat.dart';
import 'package:provider/provider.dart';
import '../../providers/main_provider.dart';
import 'serch_end_point.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late Future myFuture;
  Future? _initFuture;
  MainProvider? temp;

  @override
  void initState() {
    temp = Provider.of<MainProvider>(context, listen: false);
    super.initState();
  }

  void adddata(BuildContext context) {
    Provider.of<MainProvider>(context, listen: false).addVehicledata();
  }

  void fetchdata(BuildContext context) {
    Provider.of<MainProvider>(context, listen: false).fetchserchPref();
  }

  selectDate(BuildContext context) async {
    await Provider.of<MainProvider>(context, listen: false).selectDate(context);
    fetchdata(context);
  }

  @override
  void dispose() {
    temp!.clearpreference();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _initFuture = temp!.fetchVehicleData();
    var read = context.watch<MainProvider>();

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Consumer<MainProvider>(
            builder: (context, value, child) {
              return Column(
                children: <Widget>[
                  Container(
                    height: 300.0,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image:
                            const AssetImage('assets/images/givinglift.jpeg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 190),
                    child: FutureBuilder(
                      future: _initFuture,
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          case ConnectionState.done:
                            if (snapshot.hasError) {
                              return Text(snapshot.error.toString());
                            } else {
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: value.searchProductList.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: Icon(Icons.access_time_outlined),
                                    title: RichText(
                                      maxLines: 5,
                                      // overflow: TextOverflow.ellipsis,
                                      text: TextSpan(
                                        text:
                                            "${value.searchProductList[index].searchStartingPoint}",
                                        // "${context.watch<MainProvider>().searchProductList[index].searchStartingPoint}", //'${getuserStartingPoint[index]} ',
                                        style: const TextStyle(
                                            fontFamily: 'Roboto',
                                            color:AppColors.black,
                                            fontWeight: FontWeight.bold),
                                        children: <TextSpan>[
                                          const TextSpan(
                                              text: ' to ',
                                              style: const TextStyle(
                                                  color: AppColors.appblue,
                                                  fontWeight:
                                                      FontWeight.normal)),
                                          TextSpan(
                                              text:
                                                  "${value.searchProductList[index].serchEndPoints}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                    subtitle: Text(
                                        "${value.searchProductList[index].searchSeatBook} Passenger"),
                                  );
                                },
                              );
                            }

                          default:
                            return Text('Unhandle State');
                        }
                      },
                    ),
                  ))
                ],
              );
            },
          ),
          Positioned(
            top: 200.0,
            left: 5,
            right: 5,
            child: Container(
              height: 290.0,
              width: 400.0,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                color: AppColors.white,
                elevation: 6.0,
                child: Wrap(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (context) => searchStartPoint()))
                              .then((value) => fetchdata(context));
                        },
                        child: ListTile(
                            leading: const Icon(
                              Icons.circle_outlined,
                              color:AppColors.appblue, //Colors.blue,
                            ),
                            title: read.searchStartingPoint == null
                                ? const Text(
                                    "Start",
                                    style: const TextStyle(
                                        color: AppColors.black45,//Colors.black45,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text(read.searchStartingPoint.toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: AppColors.black45,//Colors.black45,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold))),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Divider(
                        color:AppColors.black45,// Colors.black45,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                                    builder: (context) => searchEndPoint()))
                                .then((value) => fetchdata(context));
                          },
                          child: ListTile(
                              leading: const Icon(
                                Icons.circle_outlined,
                                color: AppColors.appblue,//Colors.blue,
                              ),
                              title: read.searchDestinationPoint == null
                                  ? const Text(
                                      "Destination",
                                      style: const TextStyle(
                                          color:AppColors.black45,// Colors.black45,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text(
                                      read.searchDestinationPoint.toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: AppColors.black45,//Colors.black45,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    )),
                        )),
                    const Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Divider(
                        color: AppColors.black45,//Colors.black45,
                        thickness: 1,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10.0, left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 220,
                            child: GestureDetector(
                              onTap: () {
                                selectDate(context);
                              },
                              child: ListTile(
                                leading: const Icon(
                                  Icons.calendar_month_outlined,
                                  color:AppColors.appblue,// Colors.blue,
                                ),
                                title: Transform.translate(
                                  offset: const Offset(-25, 0),
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: read.selectedDate1 == null
                                        ? const Text(
                                            "Today                 ",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: AppColors.black38,//Colors.black38,
                                                fontWeight: FontWeight.bold),
                                          )
                                        : Text(
                                            "${read.selectedDate1.toString().substring(0, 10)}         ",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color:  AppColors.black38,//Colors.black38,
                                                fontWeight: FontWeight.bold),
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            color: AppColors.black45,// Colors.black45,
                            height: 50,
                            width: 1,
                          ),
                          Container(
                            width: 100,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                      builder: (context) => NumberOfSeat(),
                                    ))
                                    .then((value) => fetchdata(context));
                              },
                              child: ListTile(
                                  leading: const Icon(
                                    Icons.person,
                                    color:  AppColors.appblue,//Colors.blue,
                                  ),
                                  title: Transform.translate(
                                    offset: const Offset(-25, 0),
                                    child: Text(
                                      read.searchSeatBook == null
                                          ? '1'
                                          : read.searchSeatBook.toString(),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color:  AppColors.black38,//Colors.black38,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    (read.searchStartingPoint == null ||
                            read.searchDestinationPoint == null)
                        ? Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: MaterialButton(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: const Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
                                side: const BorderSide(color:  AppColors.appblue),
                              ),
                              minWidth: double.maxFinite,
                              // set minWidth to maxFinite
                              color:  AppColors.appblue,//Colors.blue,
                              onPressed: () async {},
                              child: const Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Text('Search',
                                    style: TextStyle(
                                        color: AppColors.white,//Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: MaterialButton(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
                                side: BorderSide(color: AppColors.appblue),
                              ),
                              minWidth: double.maxFinite,
                              color: AppColors.appblue,
                              onPressed: () async {
                                fetchdata(context);
                                adddata(context);
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                      builder: (context) => SearchRides(
                                        startingPoint:
                                            "${read.searchStartingPoint}",
                                        endPoint:
                                            "${read.searchDestinationPoint}",
                                      ),
                                    ))
                                    .then((value) => fetchdata(context));
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Text('Search',
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
