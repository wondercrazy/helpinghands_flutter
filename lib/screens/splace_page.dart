import 'package:flutter/material.dart';
import 'package:helping_hands/constants/all_constants.dart';
import 'package:helping_hands/providers/auth_provider.dart';
import 'package:helping_hands/screens/home_page.dart';
import 'package:helping_hands/screens/login_page.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      checkSignedIn();
    });
  }

  void checkSignedIn() async {
    AuthProvider authProvider = context.read<AuthProvider>();
    bool isLoggedIn = await authProvider.isLoggedIn();
    if (isLoggedIn) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
      return;
    }
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildText(),
            buildPadding(context),
            buildSizedBox(),
            buildSizedBox(),
            const CircularProgressIndicator(
              color: AppColors.lightGrey,
            ),
          ],
        ),
      ),
    );
  }

  FittedBox buildText() {
    return  FittedBox(
      fit: BoxFit.contain,
        child: Text(
      "Welcome to App",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: Sizes.dimen_48),
    ));
  }

  Padding buildPadding(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(
        'assets/images/splash1.jpeg',
        width: MediaQuery.of(context).size.width,
        height: 400,
      ),
    );
  }

  SizedBox buildSizedBox() {
    return const SizedBox(
      height: 20,
    );
  }
}
