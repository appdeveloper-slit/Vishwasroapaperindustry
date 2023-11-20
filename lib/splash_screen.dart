import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vpi/colors.dart';
import 'package:vpi/home_page.dart';
import 'package:vpi/login.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:upgrader/upgrader.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  bool? isLoggedIn = false;

  // test_network_and_start() async {
  //   try {
  //     final result = await InternetAddress.lookup('google.com');
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {

  //       print('connected');
  //     }
  //   } on SocketException catch (_) {
  //     print('not connected');
  //      SnackBar snackBar = SnackBar(
  //           content: Text("No Internet"),
  //         );

  //         ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   }
  // }
  
     void checkConnectivity() async {

      // Do nothing
      Timer(Duration(seconds: 3), () {
        isLoggedIn!
            ? Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeScreen()))
            : Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
      });

  }

  @override
  void initState() {
    checkConnectivity();
    getSessionData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, children: [
      //   IgnorePointer(child: Center(
      //     child: Image.asset(
      //     "assets/images/BG images.png",
      //     scale: 0.8,),
      //   )),
      //   Container(
      // color: Colors.white,
      // child: Image.asset("assets/images/logo (4).png")),
      IgnorePointer(
          child: Image.asset("assets/images/splash.png",
              scale: 0.2, fit: BoxFit.fill))
      // Text("Build: Efwfmpqfe cz Wjwfl Ujxbsj (ENC 1 caesar)"),
    ]);
  }

  getSessionData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    isLoggedIn =
        sp.getBool("isLoggedIn") != null ? sp.getBool("isLoggedIn")! : false;
  }
}
