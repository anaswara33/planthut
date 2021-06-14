import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:planthut/helper/sharedpref.dart';
import 'package:planthut/screens/home/home_screen.dart';
import 'package:planthut/screens/splash/components/body.dart';

import '../../size_config.dart';
import 'components/body.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoggedIn = true;

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    if (isLoggedIn) {
      return Scaffold(body: Container(child: Center(child: CircularProgressIndicator())));
    }
    return Scaffold(
      body: Body(),
    );
  }

  void checkLogin() async {
    if (await SharedPrefHelper.getUserId() != null && FirebaseAuth.instance.currentUser != null) {
      setState(() {
        isLoggedIn = true;
      });
      Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
    } else {
      setState(() {
        isLoggedIn = false;
      });
    }
  }
}
