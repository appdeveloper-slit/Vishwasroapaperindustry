import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart';
import 'package:vpi/colors.dart';
import 'package:vpi/globalurls.dart';
import 'package:vpi/home_page.dart';
import 'package:vpi/login.dart';
import 'package:vpi/otp_verification.dart';
// import 'package:validators/sanitizers.dart';
// import 'package:validators/validators.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  @override
  State<SignUpScreen> createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  TextEditingController signupName = TextEditingController();
  TextEditingController signupEmail = TextEditingController();
  TextEditingController signupCompanyName = TextEditingController();
  TextEditingController signupNumber = TextEditingController();
  // bool isSubmit = false;
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
                  
                  Column(
                    children: [
                      Center(
                        child: Text(
                  "Welcome",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                  ),
                      ),
                  Center(
                    child: Text(
                    "Vishwas Paper Industries",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Center(
                    child: Text(
                    "Register to create your account",
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
                        controller: signupNumber,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Your Number",
                          filled: true,
                          counterText: "",
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 14, horizontal: 12),
                          fillColor: Colors.grey[100],
                          // prefixIcon: Icon(Icons.phone_in_talk_outlined, size: 30, color: blue,),
                          // prefixIconColor:blue
                        ),
                      ),
                      SizedBox(height: 25),
                    ],
                  ),

                  

                  SizedBox(
                    width: 130,
                    child: sendload ? ElevatedButton(
                        child: Text("Send OTP"),
                        onPressed: () async {
                          
                          // login();
                          print("Name: " + signupName.text.toString());
                          print("Email: " + signupEmail.text.toString());
                          print("Company: " + signupCompanyName.text.toString());
                          print("Number: " + signupNumber.text.toString());

                          if(isLength(signupNumber.text.toString(), 10)){
setState(() {
                          sendload = false;  
                        });

                            var dio = Dio();
                            var formdata = FormData.fromMap({
                              'mobile' : signupNumber.text.toString(),
                              'page_type' : 'register',
                            });
                            final response = await dio.post(sendOTP(), data: formdata);
                            var result = response.data;
                            print(result);

                            setState(() {
                          sendload = true;  
                        });

                            if(result['success'] == true){
                              SnackBar sn = new SnackBar(content: Text(result['message'].toString()));
                              ScaffoldMessenger.of(context).showSnackBar(sn);
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => OTPVerificationScreen(mobileNumebr: signupNumber.text.toString(), name: "", email: "", companyName: "", otptype: 'registration',))));
                            }
                            else{
                              SnackBar sn = new SnackBar(content: Text(result['message'].toString()));
                              ScaffoldMessenger.of(context).showSnackBar(sn);
                            }
                          }
                          else{
                            SnackBar sn = new SnackBar(content: Text("Number must be 10 digits long"));
                              ScaffoldMessenger.of(context).showSnackBar(sn);
                          }

                          
                        }) : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(child: CircularProgressIndicator()),
                          ],
                        ),
                  ),
                  SizedBox(height: 15),
                  InkWell(
                    onTap: () {
                      print("Login tapped");
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                    },
                    child: RichText(
                        text: TextSpan(
                            text: "",
                            children: [
                              TextSpan(text: "Already have an account? "),
                              TextSpan(
                                text: "Login",
                                style: TextStyle(
                                    color: blue, fontWeight: FontWeight.w600),
                              ),
                            ],
                            style: TextStyle(color: Colors.black))),
                  ),
                  SizedBox(height: 15),
                  // InkWell(
                  //   onTap: () {
                  //     print("Home tapped");
                  //     Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                  //   },
                  //   child: RichText(
                  //       text: TextSpan(
                  //           text: "",
                  //           children: [
                  //             TextSpan(text: "Goto home for now"),
                  //           ],
                  //           style: TextStyle(color: Colors.black))),
                  // ),
                ],
              )),
        ),
      ],
    ));
  }
}
