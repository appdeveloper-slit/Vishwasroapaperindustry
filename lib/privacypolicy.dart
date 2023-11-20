import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vpi/colors.dart';
import 'package:vpi/signup.dart';
// import 'package:validators/sanitizers.dart';
// import 'package:validators/validators.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);
  @override
  State<PrivacyPolicyScreen> createState() => PrivacyPolicyScreenState();
}

class PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  TextEditingController loginMobileNumber = TextEditingController();

  Widget notificationCard() {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Container(
          child: Card(
            clipBehavior: Clip.hardEdge,
            elevation: 5,
            shadowColor: Colors.grey[100],
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Align(
                    child: Text(
                      "Notification header",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  Align(
                    child: Text(
                      "Notification content. Notification content. Notification content. Notification content. Notification content. ",
                      style: TextStyle(),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  SizedBox(height: 5,),
                  Align(
                    child: Text(
                      "notification date",
                      style: TextStyle(color: Colors.grey),
                    ),
                    alignment: Alignment.centerRight,
                  ),
                ],
              ),
            ),
          ),
          margin: EdgeInsets.all(1),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Privacy Policy"), centerTitle: true,),
        body: ListView(
          children: [
            Center(
              child: Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Text("""Lorem ipsum dolor sit amet, consectetur adipiscig lit. Amet quis eget enim, nulla a. Elementum pulvinar commodo a urna tincidunt. Luctus pulvinr in sit tellus dictum consectetur feugiat adipiscing. Amet nibh et donec porttitor dui. Lorem ipsum olor sit amet, consectetur adipiscig lit. Amet quis eget enim, nulla a. Elementum pulvinar commodo urna tincidunt. Luctus pulvinr in sit tellus dictum consectetur feugiat adipiscing. Amet nibh et donec porttitor dui.""", style:TextStyle(fontSize: 16)),
                      SizedBox(height: 15,),
                      Text("""Lorem ipsum dolor sit amet, consectetur adipiscig lit. Amet quis eget enim, nulla a. Elementum pulvinar commodo a urna tincidunt. Luctus pulvinr in sit tellus dictum consectetur feugiat adipiscing. Amet nibh et donec porttitor dui. Lorem ipsum olor sit amet, consectetur adipiscig lit. Amet quis eget enim, nulla a. Elementum pulvinar commodo urna tincidunt. Luctus pulvinr in sit tellus dictum consectetur feugiat adipiscing. Amet nibh et donec porttitor dui.""", style:TextStyle(fontSize: 16))
                    
                    ],
                  )),
            ),
          ],
        ));
  }
}
