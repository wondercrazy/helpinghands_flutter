import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helping_hands/constants/all_constants.dart';
import 'package:helping_hands/providers/auth_provider.dart';
import 'package:helping_hands/screens/home_page.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    switch (authProvider.status) {
      case Status.authenticateError:
        Fluttertoast.showToast(msg: 'Sign in failed');
        break;
      case Status.authenticateCanceled:
        Fluttertoast.showToast(msg: 'Sign in cancelled');
        break;
      case Status.authenticated:
        Fluttertoast.showToast(msg: 'Sign in successful');
        break;
      default:
        break;
    }

    return Scaffold(
      body: Stack(
        children: [
          ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(
              vertical: Sizes.dimen_30,
              horizontal: Sizes.dimen_20,
            ),
            children: [
              vertical50,
              buildText(Sizes.dimen_36,FontWeight.bold,"Welcome to App",AppColors.black),
              vertical20,
              buildText(Sizes.dimen_24,FontWeight.w500,"Login to continue",AppColors.red),
              // vertical10,
              Center(
                  child: Image.asset(
                      width: MediaQuery.of(context).size.width,
                      height: 400,
                      'assets/images/splash.png')),
              vertical10,
              GestureDetector(
                onTap: () async {
                  bool isSuccess = await authProvider.handleGoogleSignIn();
                  if (isSuccess) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }
                },
                child: Image.asset('assets/images/google_login.png'),
              ),
            ],
          ),
          Center(
            child: authProvider.status == Status.authenticating
                ? const CircularProgressIndicator(
                    color: AppColors.lightGrey,
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Text buildText(double fontsize,FontWeight fontweight,String text,Color color) {
    return  Text(
              '$text',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: fontsize,
                  fontWeight: fontweight,
                  color: color,//Constants.kDarkGreyColor
              ),
            );
  }
}
