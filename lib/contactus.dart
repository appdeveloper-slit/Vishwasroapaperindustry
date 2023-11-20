// import 'dart:html';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vpi/colors.dart';
import 'package:vpi/signup.dart';
// import 'package:validators/sanitizers.dart';
// import 'package:validators/validators.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);
  @override
  State<ContactUsScreen> createState() => ContactUsScreenState();
}

class ContactUsScreenState extends State<ContactUsScreen> {
  TextEditingController loginMobileNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contact Us"), centerTitle: true,),
      body: Align(
        alignment: Alignment.center,
        child: ListView(
          children: [
            // Container(
            //   margin: EdgeInsets.only(top: 25, left: 15),
            //   child: RichText(
            //       text: TextSpan(
            //           text: "",
            //           children: [
            //             TextSpan(
            //               text: "Name: ",
            //               style: TextStyle(fontWeight: FontWeight.w600),
            //             ),
            //             TextSpan(
            //               text: "john Doe",
            //             ),
            //           ],
            //           style: TextStyle(color: Colors.black))),
            // ),
            Container(
              margin: EdgeInsets.only(top: 25, left: 15),
              child: Row(children: [
                Text("Email: ", style: TextStyle(fontWeight: FontWeight.bold)),
                Expanded(child: Container(margin: EdgeInsets.only(left:5, right:5), child: Text("vishwaspaperindustries@gmail.com")), flex: 4,)
              ],)
            ),
            Container(
              margin: EdgeInsets.only(top: 25, left: 15),
              child: Row(children: [
                Text("Mobile Number: ", style: TextStyle(fontWeight: FontWeight.bold)),
                Expanded(child: Container(margin: EdgeInsets.only(left:5, right:5), child: Text("9702623346/ 7021455883")), flex: 4,)
              ],)
            ),
            Container(
              margin: EdgeInsets.only(top: 25, left: 15),
              child: Row(children: [
                Container(padding: EdgeInsets.only(bottom: 15), child: Text("Address: ", style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(child: Container(margin: EdgeInsets.only(left:5, right:5), child: Text("3074, 3rd Floor, Pannlal Indl. Estate, L.B.S Marg, Bhandup(W), Mumbai - 400 078")), flex: 4,)
              ],)
            ),
          ],
        ),
      ),
    );
  }
}
