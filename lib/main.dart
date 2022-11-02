import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:helping_hands/firebase_options.dart';
import 'package:helping_hands/navigation/navigation.dart';
import 'package:helping_hands/providers/addcarride_provider.dart';
import 'package:helping_hands/providers/addvehicle_provider.dart';
import 'package:helping_hands/providers/auth_provider.dart';
import 'package:helping_hands/providers/edit_profile_provider.dart';
import 'package:helping_hands/providers/main_provider.dart';
import 'package:helping_hands/providers/profile_provider.dart';
import 'package:helping_hands/providers/search_vehicle_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // GoogleSignIn(clientId: DefaultFirebaseOptions.currentPlatform.iosClientId).signIn();
  // await FirebaseAppCheck.instance
  //     .activate(webRecaptchaSiteKey: 'recaptcha-v3-site-key');
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // await FirebaseAppCheck.instance.activate();
  // await FirebaseAppCheck.instance.setTokenAutoRefreshEnabled(true);
  // FirebaseAppCheck.instance.onTokenChange.listen((token) {
  //   print(token);
  // });
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // FirebaseCrashlytics.instance.crash();
  runApp(MyApp(
    prefs: prefs,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  MyApp({Key? key, required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
            create: (_) => AuthProvider(
                firebaseFirestore: firebaseFirestore,
                prefs: prefs,
                googleSignIn: GoogleSignIn(),
                firebaseAuth: FirebaseAuth.instance)),
        Provider<ProfileProvider>(
            create: (_) => ProfileProvider(
                prefs: prefs,
                firebaseFirestore: firebaseFirestore,
                firebaseStorage: firebaseStorage)),
        // ChangeNotifierProvider<searchVehicleHistoryProvider>(
        //     create: (context) => searchVehicleHistoryProvider(context)),
        ChangeNotifierProvider<SearchVehicleProvider>(
            create: (context) => SearchVehicleProvider(context)),
        ChangeNotifierProvider<MainProvider>(
            create: (context) => MainProvider(context)),
        ChangeNotifierProvider<AddCarProvider>(
          create: (context) => AddCarProvider(context),
        ),
        ChangeNotifierProvider<AddVehicleProvider>(
          create: (context) => AddVehicleProvider(context),
        ),
        ChangeNotifierProvider<editProfileProvider>(
          create: (context) => editProfileProvider(context),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Helping Hands',
        initialRoute: '/',
        routes: Navigate.routes,
      ),
    );
  }
}
