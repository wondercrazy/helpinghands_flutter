import 'package:flutter/material.dart';
import 'package:helping_hands/providers/auth_provider.dart';
import 'package:helping_hands/screens/login_page.dart';
import 'package:helping_hands/screens/profile/phone_number.dart';
import 'package:provider/provider.dart';

import '../../constants/color_constants.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  late AuthProvider authProvider;
  late String currentUserId;

  Future<void> googleSignOut() async {
    authProvider.googleSignOut();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    super.initState();
    authProvider = context.read<AuthProvider>();

    if (authProvider.getFirebaseUserId()?.isNotEmpty == true) {
      currentUserId = authProvider.getFirebaseUserId()!;
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (Route<dynamic> route) => false);
    }
    // scrollController.addListener(scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Setting",
            style: TextStyle(
                color: AppColors.black, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: AppColors.white,
          elevation: 0,
          foregroundColor: AppColors.appblue),
      body: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PhoneNumber(),
                ));
              },
              child: ListTile(
                title: Text(
                  "Phone Number",
                  style: TextStyle(fontSize: 18),
                ),
                subtitle: Text(
                  "+91 6482910452",
                  style: TextStyle(fontSize: 12),
                ),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: ListTile(
                title: Text(
                  "Notification",
                  style: TextStyle(fontSize: 18),
                ),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: ListTile(
                title: Text(
                  "Language",
                  style: TextStyle(fontSize: 18),
                ),
                subtitle: Text(
                  "defualt language",
                  style: TextStyle(fontSize: 12),
                ),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: ListTile(
                title: Text(
                  "Date and Distance",
                  style: TextStyle(fontSize: 18),
                ),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: ListTile(
                title: Text(
                  "Ruls and Terms",
                  style: TextStyle(fontSize: 18),
                ),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
            GestureDetector(
              onTap: () => googleSignOut(),
              child: ListTile(
                title: Text(
                  "Logout",
                  style: TextStyle(fontSize: 18, color: AppColors.green),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
