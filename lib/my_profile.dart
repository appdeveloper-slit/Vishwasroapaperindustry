import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart';
import 'package:vpi/colors.dart';
import 'package:vpi/globalurls.dart';
import 'package:vpi/signup.dart';
// import 'package:validators/sanitizers.dart';
// import 'package:validators/validators.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);
  @override
  State<MyProfileScreen> createState() => MyProfileScreenState();
}

class MyProfileScreenState extends State<MyProfileScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController newMobileNumber = TextEditingController();
  TextEditingController otpField = TextEditingController();
  bool fetchload = false;
  bool isOTPsent = false;
  bool otpsendload = true;

  // String errorText = "";
  ValueNotifier<String> errorText = ValueNotifier<String>('');
  bool isLoggedIn = false;
  ValueNotifier<int> totaltime = ValueNotifier<int>(60);
  ValueNotifier<bool> resendEnabled = ValueNotifier<bool>(false);
  bool shouldStop = true;
  bool isNotDisabled = true;
  var periodicTimer;



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
          if(totaltime.value <= 0){
            resendEnabled.value = true;
            shouldStop = true;
            totaltime.value = 0;
          }
          else{
            totaltime.value--;
          }
          
        });
        
      });
    

  }
  

  void getProfile() async {
    setState(() {
      fetchload = false;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var dio = Dio();
    var formdata = FormData.fromMap({
      'user_id': prefs.getString('user_id'),
    });
    final response = await dio.post(getProfileUrl(), data: formdata);
    var result = response.data;
    print(result);

    setState(() {
      fetchload = true;
    });

    if (result['success'] == true) {
      name.text = result['name'].toString();
      email.text = result['email'].toString();
      mobile.text = result['mobile'].toString();
    }
  }

  void sendAnOTP() async {
    setState(() {
      otpsendload = false;
      totaltime.value = 60;
    });
    resendOtpTimer();
    var dio = Dio();
    var formData =
        FormData.fromMap({'mobile': newMobileNumber.text.toString()});
    final response = await dio.post(sendOTP(), data: formData);
    var res = response.data;
    print(res);
    setState(() {
      otpsendload = true;
      isOTPsent = true;
      errorText.value = "OTP sent please enter";
    });
    if (res["success"] == true) {
      // SnackBar sn = SnackBar(content: Text(res['message'].toString()));
      // ScaffoldMessenger.of(context).showSnackBar(sn);
      setState(() {
        errorText.value = res['message'].toString();
        isOTPsent = true;
      });
    } else {
      // SnackBar sn = SnackBar(content: Text(res['message'].toString()));
      // ScaffoldMessenger.of(context).showSnackBar(sn);
      setState(() {
        errorText.value = res['message'].toString();
        isOTPsent = false;
      });
    }

    setState(() {
      isOTPsent = isOTPsent;
      errorText = errorText;
    });
  }

  void resendtheOTP() async {
    errorText.value = "Please wait...";
    var dio = Dio();
      var formData = FormData.fromMap({
        "mobile": newMobileNumber.text.toString(),
      });
      final response = await dio.post(resendOTP(), data: formData);
      var res = response.data;
      print(res);
      // SnackBar snk = new SnackBar(
      //     content: Text(res["message"]),
      //   );
        errorText.value = res["message"].toString();
        // ScaffoldMessenger.of(context).showSnackBar(snk);
  }

  void updateProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if ((email.text.isNotEmpty && isEmail(email.text.toString()) ||
        email.text.isEmpty)) {
      if (isLength(name.text.toString(), 1)) {
        var dio = Dio();
        var formdata = FormData.fromMap({
          'user_id': prefs.getString('user_id'),
          'name': name.text.toString(),
          'email': email.text.toString()
        });
        final response = await dio.post(updateProfileUrl(), data: formdata);
        var result = response.data;
        print(result);
        if (result['success'] == true) {
          SnackBar sn =
              new SnackBar(content: Text(result['message'].toString()));
          ScaffoldMessenger.of(context).showSnackBar(sn);
        } else {
          SnackBar sn =
              new SnackBar(content: Text(result['message'].toString()));
          ScaffoldMessenger.of(context).showSnackBar(sn);
        }
      } else {
        SnackBar sn = new SnackBar(content: Text("Please enter a name"));
        ScaffoldMessenger.of(context).showSnackBar(sn);
      }
    } else {
      // Invalid email
      SnackBar sn = new SnackBar(content: Text("Invalid email"));
      ScaffoldMessenger.of(context).showSnackBar(sn);
    }
  }

  void changeMobilePopUp() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          newMobileNumber.text = "";
          errorText.value = "";
          otpsendload = true;
          isOTPsent = false;
          otpField.text = "";
          totaltime.value = 60;
          return StatefulBuilder(builder: (context, setState) {
            errorText.addListener(() {
              setState(() {
                errorText = errorText;
              });
            });

            totaltime.addListener(() {
              setState(() {
                totaltime = totaltime;
              });
            });

            resendEnabled.addListener(() {
              setState(() {
                resendEnabled = resendEnabled;
              });
            });

            return SizedBox(
              // height: (!(MediaQuery.of(context).size.height < 500))
              //     ? MediaQuery.of(context).size.height - 800
              //     : MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: AlertDialog(
                // insetPadding: EdgeInsets.zero,
                contentPadding: EdgeInsets.zero,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                title: Center(child: Text("Change mobile number")),
                content: SizedBox(
                  // height: (!(MediaQuery.of(context).size.height < 500))
                  //     ? MediaQuery.of(context).size.height -
                  //         (isOTPsent ? 650 : 700)
                  //     : MediaQuery.of(context).size.height,
                  // width:
                  //     MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    physics: const ScrollPhysics(),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(
                          top: 25, left: 10, right: 10, bottom: 25),
                      child: Column(
                          // crossAxisAlignment:
                          //     CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.number,
                              controller: newMobileNumber,
                              maxLength: 10,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Mobile Number",
                                  filled: true,
                                  counterText: "",
                                  fillColor: Colors.grey[100],
                                  prefixIcon: Icon(
                                    Icons.phone_in_talk_outlined,
                                    color: blue,
                                  ),
                                  prefixIconColor: blue),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            (isOTPsent)
                                ? TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: otpField,
                                    maxLength: 4,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Enter OTP",
                                        filled: true,
                                        counterText: "",
                                        fillColor: Colors.grey[100],
                                        prefixIcon: Icon(
                                          Icons.lock_outline,
                                          color: blue,
                                        ),
                                        prefixIconColor: blue),
                                  )
                                : Container(),
                            SizedBox(
                              height: 15,
                            ),
                            (errorText.value.toString().isNotEmpty)
                                ? Center(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Icon(Icons.info_outline),
                                        Expanded(
                                            child: Container(
                                                child: Text(errorText.value),
                                                margin:
                                                    EdgeInsets.only(left: 10))),
                                      ],
                                    ),
                                  )
                                : Text(errorText.value.toString()),

                                isOTPsent ?  resendEnabled.value ?  Center(
          child: InkWell(
            onTap: () {
              resendtheOTP();
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
        ) : Text("Resend OTP in " + totaltime.value.toString() + " seconds") : Text("")

                          ]),
                    ),
                  ),
                ),
                actionsAlignment: MainAxisAlignment.spaceEvenly,
                actions: [
                  TextButton(
                      onPressed: () {
                        isOTPsent = false;
                        Navigator.of(context).pop();
                      },
                      child: Text("Cancel")),
                  (isOTPsent)
                      ? otpsendload
                          ? SizedBox(
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    elevation:
                                        MaterialStateProperty.all<double>(
                                            0)),
                                onPressed: () async {
                                  if (isLength(otpField.text, 4)) {
                                    // verifyOTPAndSaveMobile(setState, context);
                                    setState(() {
                                      otpsendload = false;
                                    });

                                    var dio = Dio();
                                    SharedPreferences sp =
                                        await SharedPreferences
                                            .getInstance();
                                    var formData = FormData.fromMap({
                                      'mobile':
                                          newMobileNumber.text.toString(),
                                      'user_id': sp.getString('user_id'),
                                      'otp': otpField.text.toString()
                                    });
                                    final response = await dio.post(
                                        updateProfileMobileUrl(),
                                        data: formData);
                                    var res = response.data;
                                    print(res);

                                    if (res["success"] == false) {
                                      setState(() {
                                        otpsendload = true;
                                        errorText.value =
                                            res['message'].toString();
                                      });
                                    } else {
                                      sp.setString(
                                          'mobile', newMobileNumber.text);
                                      mobile.text =
                                          sp.getString('mobile').toString();
                                      setState(() {
                                        otpsendload = true;
                                        errorText.value =
                                            "Verified and saved!";
                                      });
                                      Navigator.of(context).pop();
                                    }
                                  }
                                },
                                child: Text("Verify")),
                          )
                          : SizedBox(
                          child: CircularProgressIndicator(),
                          width: 20,
                          height: 20,
                            )
                      : otpsendload
                          ? SizedBox(
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      elevation:
                                          MaterialStateProperty.all<double>(0)),
                                  onPressed: () {
                                    if (isLength(newMobileNumber.text, 10)) {
                                      sendAnOTP();

                                      setState(() {
                                        errorText = errorText;
                                        isOTPsent = isOTPsent;
                                      });
                                    } else {
                                      errorText.value = "Invalid mobile number";
                                      setState(
                                        () {
                                          errorText = errorText;
                                        },
                                      );
                                    }
                                  },
                                  child: Text("Send OTP")),
                            )
                          : SizedBox(
                          child: CircularProgressIndicator(),
                          width: 20,
                          height: 20,
                            ),
                ],
              ),
            );
          });
        }).then((value) {
          print("[i] Disposing timer periodic....");
          periodicTimer?.cancel();
          print("[+] Dispose executed...");
        });
  }

  @override
  void initState() {
    getProfile();

    errorText.addListener(() {
      setState(() {
        errorText = errorText;
      });
    });
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
        appBar: AppBar(
          title: Text("My Profile"),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Center(
              child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Align(
                        child: Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text(
                            "Name",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                      TextFormField(
                        // maxLength: 10,
                        // keyboardType: TextInputType.number,
                        controller: name,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Your Name",
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                maxLength: 10,
                                keyboardType: TextInputType.number,
                                enabled: false,
                                controller: mobile,
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
                            ),
                            InkWell(
                              onTap: () {
                                print("Edit mobile pressed");

                                changeMobilePopUp();
                              },
                              child: Container(
                                color: Colors.grey[100],
                                padding: EdgeInsets.only(
                                    top: 12, bottom: 12, left: 14, right: 14),
                                child: Icon(
                                  Icons.edit_outlined,
                                  color: blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 25),
                      Align(
                        child: Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text(
                            "Email",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                      TextFormField(
                        // maxLength: 10,
                        keyboardType: TextInputType.emailAddress,
                        controller: email,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Your Email",
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            child: Text("Update Profile"),
                            onPressed: () {
                              updateProfile();
                              // login();
                            }),
                      ),
                      SizedBox(height: 25),
                      fetchload
                          ? Text("")
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("fetching data please wait..."),
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  child: CircularProgressIndicator(),
                                  width: 20,
                                  height: 20,
                                )
                              ],
                            ),
                      SizedBox(height: 15),
                    ],
                  )),
            ),
          ],
        ));
  }
}
