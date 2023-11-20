import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart';
import 'package:vpi/colors.dart';
import 'package:vpi/globalurls.dart';
import 'package:vpi/otp_verification.dart';
import 'package:vpi/signup.dart';
// import 'package:validators/sanitizers.dart';
// import 'package:validators/validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController loginMobileNumber = TextEditingController();
  bool sendload = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Center(
          child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text('Welcome Back Vishwas Paper Industries',
                      style: TextStyle(
                        fontSize: 24.0,
                      ),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 15.0),
                  const Center(
                    child: Text(
                      "Login to continue",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Align(
                    child: Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Text(
                        "Mobile Number",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  TextFormField(
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    controller: loginMobileNumber,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Your Number",
                      filled: true,
                      counterText: "",
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                      fillColor: Colors.grey[100],
                      // prefixIcon: Icon(Icons.phone_in_talk_outlined, size: 30, color: blue,),
                      // prefixIconColor:blue
                    ),
                  ),
                  SizedBox(height: 25),
                  sendload
                      ? SizedBox(
                          width: 130,
                          child: ElevatedButton(
                              child: Text("Send OTP"),
                              onPressed: () async {
                                if (isLength(
                                    loginMobileNumber.text.toString(), 10)) {
                                  setState(() {
                                    sendload = false;
                                  });
                                  var dio = Dio();
                                  var formdata = FormData.fromMap({
                                    'mobile': loginMobileNumber.text.toString(),
                                    'page_type': 'login',
                                  });
                                  final response =
                                      await dio.post(sendOTP(), data: formdata);
                                  var result = response.data;
                                  print(result);

                                  setState(() {
                                    sendload = true;
                                  });

                                  if (result['success'] == true) {
                                    SnackBar sn = new SnackBar(
                                        content:
                                            Text(result['message'].toString()));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(sn);
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                OTPVerificationScreen(
                                                  mobileNumebr:
                                                      loginMobileNumber.text
                                                          .toString(),
                                                  name: "",
                                                  email: "",
                                                  companyName: "",
                                                  otptype: "login",
                                                ))));
                                  } else {
                                    SnackBar sn = new SnackBar(
                                        content:
                                            Text(result['message'].toString()));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(sn);
                                  }
                                } else {
                                  SnackBar sn = new SnackBar(
                                      content: Text(
                                          "Number must be 10 digits long"));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(sn);
                                }

                                // login();
                              }),
                        )
                      : CircularProgressIndicator(),
                  SizedBox(height: 15),
                  InkWell(
                    onTap: () {
                      print("Register tapped");
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                    },
                    child: RichText(
                        text: TextSpan(
                            text: "",
                            children: [
                              TextSpan(text: "Don't have an account? "),
                              TextSpan(
                                text: "Register Now",
                                style: TextStyle(
                                    color: blue, fontWeight: FontWeight.w600),
                              ),
                            ],
                            style: TextStyle(color: Colors.black))),
                  ),
                ],
              )),
        ),
      ],
    ));
  }
}
