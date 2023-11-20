// import 'dart:html';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vpi/colors.dart';
import 'package:vpi/signup.dart';
// import 'package:validators/sanitizers.dart';
// import 'package:validators/validators.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);
  @override
  State<AboutUsScreen> createState() => AboutUsScreenState();
}

class AboutUsScreenState extends State<AboutUsScreen> {
  TextEditingController loginMobileNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About Us"), centerTitle: true,),
      body: Align(
        alignment: Alignment.center,
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                
                children: [
                Expanded(child: Container(margin: EdgeInsets.only(left:10, right:5), child: Text("""
VISHWAS PAPER INDUSTRIES a Privately Owned and
professionally managed business which was founded in
2005 firstly know as Mauli Enterprises as a small firm then
started VISHWAS PAPER INDUSTRIES since 2009 by
Director / Proprietor VISHWAS CHIMAJI YAMKAR from the
village of Patan, located in Satara(Maharashtra) along with
SONAL VISHWAS YAMKAR (General Managing Director) had
started our Paper Trading business in Mumbai, Pune, Nagpur,
Nashik, Satara, Kolhapur, Morbi, Vapi, Utthar Pradesh and all
over India.
""", style: TextStyle(fontSize: 14),)))
              ],)
            ),

Container(
              // margin: EdgeInsets.only(top: 25, left: 15),
              child: Row(children: [
                Expanded(child: Container(margin: EdgeInsets.only(left:10, right:5), child: Text("""
The company has since then grown significantly and
continues to evolve to keep pace with the changing times of
the Industry.

We deal with all types of Duplex Boards, White Back Boards,
Kraft Paper in Sheets and Reel form. We provide best quality
product with profitable rates. We have stock of 1000MT at
our Bhiwandi Godown.

Customers Satisfaction is our Moto.
""", style: TextStyle(fontSize: 14),)))
              ],)
            ),

            Container(
              // margin: EdgeInsets.only(top: 25, left: 15),
              child: Row(children: [
                Expanded(child: Container(margin: EdgeInsets.only(left:10, right:5), child: Text("""
Growth
""", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)))
              ],)
            ),

            Container(
              // margin: EdgeInsets.only(top: 25, left: 15),
              child: Row(children: [
                Expanded(child: Container(margin: EdgeInsets.only(left:10, right:5), child: Text("""
VISHWAS PAPER INDUSTRIES provides a broad range of
high quality products. Combined with our cost advantage,
pledge to provide quality and service, and our comprehensive
approach to sustainability enhances our competitive .
""", style: TextStyle(fontSize: 14),)))
              ],)
            ),

            Container(
              // margin: EdgeInsets.only(top: 25, left: 15),
              child: Row(children: [
                Expanded(child: Container(margin: EdgeInsets.only(left:10, right:5), child: Text("""
Our Mission
""", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)))
              ],)
            ),

             Container(
              // margin: EdgeInsets.only(top: 25, left: 15),
              child: Row(children: [
                Expanded(child: Container(margin: EdgeInsets.only(left:10, right:5), child: Text("""
We are committed to innovative growth through our personal
passion, reinforced by a professional mind set, creating
values for all those we touch. We have exceedingly
centralized our focus on working towards the mission .
""", style: TextStyle(fontSize: 14),)))
              ],)
            ),

          ],
        ),
      ),
    );
  }
}
