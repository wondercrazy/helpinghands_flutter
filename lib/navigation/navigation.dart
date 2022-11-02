import 'package:flutter/material.dart';
import 'package:helping_hands/screens/home_page.dart';
import 'package:helping_hands/screens/splace_page.dart';
import '../screens/needs/main_view.dart';
import '../screens/profile/profile.dart';

class Navigate {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => SplashPage(),
    '/sign-in': (context) => SplashPage(),
    '/home': (context) => HomePage(),
    '/raise': (context) => MainView(),
    '/screens.profile': (context) => Profile(),
  };
}
