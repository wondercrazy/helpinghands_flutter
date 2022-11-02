import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:helping_hands/providers/profile_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/color_constants.dart';

class searchStartPoint extends StatefulWidget {
  const searchStartPoint({Key? key}) : super(key: key);

  @override
  State<searchStartPoint> createState() => _searchStartPointState();
}

const kGoogleApiKey =
    'AIzaSyDQ2c_pOSOFYSjxGMwkFvCVWKjYOM9siow';
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _searchStartPointState extends State<searchStartPoint> {
 String? fetchstartingpoint ;
  Set<Marker> markersList = {};

  late GoogleMapController googleMapController;

  final Mode _mode = Mode.overlay;
  LatLng? currentPostion;
  void _getUserLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    var position = await GeolocatorPlatform.instance.getCurrentPosition();

    setState(() {
      currentPostion = LatLng(position.latitude, position.longitude);
    });
  }

 TextEditingController? userserchstartingController;
  @override
  void dispose() {
    super.dispose();
    fetchstartingpoint;
  }
late ProfileProvider profileProvider;
  var fullStartingPointAddress;
@override
void initState() {
  super.initState();
  _getUserLocation();

}
final _formKeys = GlobalKey<FormState>();
addPrefSearchStartingPoint() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('searchStartingPoint', "$fullStartingPointAddress");//fetchstartingpoint
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScaffoldKey,
      body:

          Stack(
        children: [
          currentPostion == null
              ? Center(child: CircularProgressIndicator())
              : GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: currentPostion!,
                    zoom: 11,
                  ), //initialCameraPosition,
                  markers: markersList,
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  compassEnabled: false,
                  myLocationButtonEnabled: false,
                  zoomGesturesEnabled: true,
                  zoomControlsEnabled: false,
                  onMapCreated: (GoogleMapController controller) {
                    googleMapController = controller;
                  },
                ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0, left: 20, right: 20),
              child: Container(
                decoration: BoxDecoration(
                  color:AppColors.white54,

                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                // width: width * 0.9,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 10.0, left: 20, right: 20),
                  child: Form(
                    key: _formKeys,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextFormField(
                          controller:userserchstartingController,
                          cursorColor: Colors.transparent,
                          cursorWidth: 0,
                          onTap: _handlePressButton,
                          onChanged: (value) {
                            fetchstartingpoint=value;
                          },
                          decoration: new InputDecoration(
                            labelText: 'Choose starting point',
                            filled: true,
                            fillColor: AppColors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              borderSide: BorderSide(
                                color: AppColors.greyshade400,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              borderSide: BorderSide(
                                color: AppColors.blueshade300,
                                width: 2,
                              ),
                            ),
                            contentPadding: EdgeInsets.all(15),
                            hintText: '${fetchstartingpoint == null ? "" : fetchstartingpoint}',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  (fetchstartingpoint != '' && fetchstartingpoint != null )
                      ? ClipOval(
                          child: Material(
                            color: AppColors.appblue, // button color
                            child: InkWell(
                              splashColor:
                              AppColors.blueshade100, // inkwell color
                              child: SizedBox(
                                width: 56,
                                height: 56,
                                child: Icon(Icons.arrow_forward),
                              ),
                              onTap: () {
                                addPrefSearchStartingPoint();
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        )
                      : ClipOval(
                          child: Material(
                            color: AppColors.grey, // button color
                            child: InkWell(
                              splashColor:
                              AppColors.blueshade100, // inkwell color
                              child: SizedBox(
                                width: 56,
                                height: 56,
                                child: Icon(Icons.arrow_forward),
                              ),
                              onTap: () {},
                            ),
                          ),
                        ),
                ],
              ),
              // ),
            ),
          ),
        ],
      ),
      // ),
    );
  }

  Future<void> _handlePressButton() async {
    Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: kGoogleApiKey,
        onError: onError,
        mode: _mode,
        language: 'en',
        strictbounds: false,
        types: [""],
        decoration: InputDecoration(
            hintText: 'Search',
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: AppColors.white))),
        components: [Component(Component.country, "ind")]);
    fullStartingPointAddress=p!.description.toString();
 print("------------------------------------ ${p.description.toString()}");
    displayPrediction(p, homeScaffoldKey.currentState);
  }

  void onError(PlacesAutocompleteResponse response) {
    homeScaffoldKey.currentState!
        .showSnackBar(SnackBar(content: Text(response.errorMessage!)));
  }

  Future<void> displayPrediction(
      Prediction p, ScaffoldState? currentState) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders());

    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);

    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;

    markersList.clear();
    markersList.add(
      Marker(
        markerId: const MarkerId("0"),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: detail.result.name),
      ),
    );

    setState(() {
     fetchstartingpoint = "${detail.result.name}";
    });

    googleMapController
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0));
  }
}
