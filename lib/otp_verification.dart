import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vpi/colors.dart';
import 'package:vpi/globalurls.dart';
import 'package:vpi/home_page.dart';
import 'package:vpi/login.dart';
import 'package:vpi/register_user_further.dart';
import 'package:vpi/signup.dart';
// import 'package:validators/sanitizers.dart';
// import 'package:validators/validators.dart';

class OTPVerificationScreen extends StatefulWidget {
  String mobileNumebr;
  String name;
  String email;
  String companyName;
  String otptype;

  OTPVerificationScreen({required this.mobileNumebr, required this.name, required this.email, required this.companyName, required this.otptype});
  @override
  State<OTPVerificationScreen> createState() =>
      OTPVerificationScreenState(mobileNumebr: mobileNumebr, name: name, email: email, companyName: companyName, otptype: otptype);
}

class OTPVerificationScreenState extends State<OTPVerificationScreen> {
  String mobileNumebr;
  String name;
  String email;
  String companyName;
  String otptype;
  OTPVerificationScreenState({required this.mobileNumebr, required this.name, required this.email, required this.companyName, required this.otptype});

  TextEditingController otpController = TextEditingController();
  bool sendload = true;
  var periodicTimer;
  int totaltime = 60;
  bool resendEnabled = false;
  bool shouldStop = true;

    void resendOtpTimer(){
    shouldStop = false;

    periodicTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        
        // Update user about remaining time
        setState(() {
          if (timer.isActive) {
            print("Timer Active...");
            if (shouldStop) {
            timer.cancel();
          }
        }
          if(totaltime <= 0){
            resendEnabled = true;
            shouldStop = true;
            totaltime = 0;
          }
          else{
            totaltime--;
          }
          
        });
        
      });
    

  }

  @override
  void initState() {
    // TODO: implement initState
    resendOtpTimer();
    super.initState();
  }

    @override
  void dispose() {
    super.dispose();
    print("[i] Disposing timer periodic....");
    periodicTimer?.cancel();
    print("[+] Dispose executed...");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: 150,
        ),
        Center(
          child: Text(
            "OTP Verification",
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        ),
        Center(child: Text("code is sent to " + mobileNumebr.toString())),
        SizedBox(
          height: 25,
        ),
        // OTP Fields
        Container(
          margin: EdgeInsets.only(left: 50, right: 50),
          child: PinCodeTextField(
            keyboardType: TextInputType.number,
            length: 4,
            obscureText: false,
            animationType: AnimationType.scale,
            cursorColor: blue,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.underline,
              borderRadius: BorderRadius.circular(2),
              fieldHeight: 50,
              fieldWidth: 50,
              activeFillColor: Colors.white,
              selectedFillColor: Colors.white,
              inactiveFillColor: Colors.white,
              inactiveColor: Colors.grey,
              activeColor: blue,
              selectedColor: blue,
            ),
            // animationDuration: Duration(milliseconds: 300),
            enableActiveFill: true,
            controller: otpController,
            onCompleted: (v) {
              print("Completed");
              print(v);
            },
            onChanged: (value) {},
            // validator: (value) {
            //   if (value!.isEmpty || !RegExp(r'(.{4,})').hasMatch(value)) {
            //     return "";
            //   } else {
            //     return null;
            //   }
            // },
            appContext: context,
          ),
        ),
        SizedBox(
          height: 25,
        ),
        resendEnabled ? Center(
          child: InkWell(
            onTap: () async {
              print("resend tapped");

              var dio = Dio();
              var formdata =
                  FormData.fromMap({'mobile': mobileNumebr.toString()});
              final response = await dio.post(resendOTP(), data: formdata);
              var result = response.data;
              print(result);

              if (result['success'] == true) {
                SnackBar sn = new SnackBar(
                    content: Text(
                        result['message'].toString() + " to $mobileNumebr"));
                ScaffoldMessenger.of(context).showSnackBar(sn);
              } else {
                SnackBar sn =
                    new SnackBar(content: Text(result['message'].toString()));
                ScaffoldMessenger.of(context).showSnackBar(sn);
              }
            },
            child: RichText(
                text: TextSpan(
                    text: "",
                    children: [
                      TextSpan(text: "If you didn't receive code! "),
                      TextSpan(
                        text: "Resend",
                        style:
                            TextStyle(color: blue, fontWeight: FontWeight.w600),
                      ),
                    ],
                    style: TextStyle(color: Colors.black))),
          ),
        ) : Text("Resend OTP (" + totaltime.toString() + " seconds)"),

        SizedBox(
          height: 25,
        ),
        Container(
          width: 250,
          child: sendload
              ? ElevatedButton(
                  onPressed: () async {
                    print("CURRENT OTP : " + otpController.text.toString());
                    print("CURRENT MOBILE NUMBER : " + mobileNumebr.toString());
                    setState(() {
                            sendload = false;  
                          });
                    
                    
                    if(otptype == 'login'){

                    var dio = Dio();
                    var formdata = FormData.fromMap({
                      'mobile': mobileNumebr.toString(),
                      'otp': otpController.text.toString(),
                    });
                    final response = await dio.post(loginUrl(), data: formdata);
                    var result = response.data;
                    print(result);
                    setState(() {
                            sendload = true;  
                          });

                    if (result['success'] == true) {

                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setBool('isLoggedIn', true);
                      // prefs.setString('name', res["user_name"].toString());
                      // prefs.setString('mobile', this.mobile.toString());
                      // prefs.setString('email', res['user_email'].toString());
                      prefs.setString('user_id', result["user_id"].toString());

                      SnackBar sn = new SnackBar(
                          content: Text(result['message'].toString()));
                      ScaffoldMessenger.of(context).showSnackBar(sn);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: ((context) => HomeScreen())));
                    } else {
                      SnackBar sn = new SnackBar(
                          content: Text(result['message'].toString()));
                      ScaffoldMessenger.of(context).showSnackBar(sn);
                    }

                    }
                    else{
                      
                    var dio = Dio();
                    var formdata = FormData.fromMap({
                      'mobile': mobileNumebr.toString(),
                      'otp': otpController.text.toString(),
                    });
                    final response = await dio.post(verifyOTP(), data: formdata);
                    var result = response.data;
                    print(result);
                    setState(() {
                            sendload = true;  
                          });

                    if (result['success'] == true) {
                      SnackBar sn = new SnackBar(
                          content: Text(result['message'].toString()));
                      ScaffoldMessenger.of(context).showSnackBar(sn);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: ((context) => SignUpFurtherScreen(mobileNumber: mobileNumebr.toString(),))));
                    } else {
                      SnackBar sn = new SnackBar(
                          content: Text(result['message'].toString()));
                      ScaffoldMessenger.of(context).showSnackBar(sn);
                    }

                    }


                  },
                  child: Text("Verify"))
              : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: CircularProgressIndicator()),
                ],
              ),
        )
      ],
    ));
  }
}
