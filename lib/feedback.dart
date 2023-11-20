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

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);
  @override
  State<FeedbackScreen> createState() => FeedbackScreenState();
}

class FeedbackScreenState extends State<FeedbackScreen> {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController mobileCtrl = TextEditingController();
  TextEditingController messageCtrl = TextEditingController();
  bool isFeedBackSend = true;
  bool fetchload = true;

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
      nameCtrl.text = result['name'].toString();
      emailCtrl.text = result['email'].toString();
      mobileCtrl.text = result['mobile'].toString();
    }
  }

  void sendFeedback() async {
    setState(() {
      isFeedBackSend = false;
    });
    var dio = Dio();
    var formdata = FormData.fromMap({
      'name': nameCtrl.text.toString(),
      'email': emailCtrl.text.toString(),
      'mobile': mobileCtrl.text.toString(),
      'message': messageCtrl.text.toString(),
    });
    final response = await dio.post(feedbackUrl(), data: formdata);
    var result = response.data;
    print(result);

    setState(() {
      isFeedBackSend = true;
    });

    if(result['success'] == true){
      SnackBar sn = SnackBar(content: Text(result['message']));
      ScaffoldMessenger.of(context).showSnackBar(sn);
      nameCtrl.text = "";
      emailCtrl.text = "";
      mobileCtrl.text = "";
      messageCtrl.text = "";

      // Navigator.pop(context);
    }
    else{
      SnackBar sn = SnackBar(content: Text(result['message']));
      ScaffoldMessenger.of(context).showSnackBar(sn);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Feedback"), centerTitle: true,),
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
                    controller: nameCtrl,
                    decoration: InputDecoration(
                      hintText: "Enter Your Name",
                      border: InputBorder.none,
                      // hintText: "Enter Your Number",
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
                  Align(
                    child: Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Text(
                        "Email (Optional)",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  TextFormField(
                    // maxLength: 10,
                    keyboardType: TextInputType.emailAddress,
                    controller: emailCtrl,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Your Email",
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
                    controller: mobileCtrl,
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
                  Align(
                    child: Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Text(
                        "Message",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  TextFormField(
                    // maxLength: 10,
                    // keyboardType: TextInputType.number,
                    controller: messageCtrl,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Your Message",
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
                  SizedBox(
                    width: 100,
                    child: isFeedBackSend ? ElevatedButton(
                        child: Text("Submit", style: TextStyle(fontSize: 16),),
                        onPressed: () async {
                          if(isLength(nameCtrl.text.toString(), 1)){
                            if((emailCtrl.text.isNotEmpty && isEmail(emailCtrl.text.toString()) ||
        emailCtrl.text.isEmpty)){
                              if(isLength(mobileCtrl.text.toString(), 10)){
                                if(isLength(messageCtrl.text.toString(), 1)){
                                  sendFeedback();
                                }
                                else{
                                  // MESSAGE
                                  SnackBar sn = SnackBar(content: Text("Please type a message"));
                                  ScaffoldMessenger.of(context).showSnackBar(sn);
                                }

                              }
                              else{
                                // MOBILE
                                SnackBar sn = SnackBar(content: Text("Please enter a valid mobile number"));
                                ScaffoldMessenger.of(context).showSnackBar(sn);
                              }

                            }
                            else{
                              // EMAIL
                              SnackBar sn = SnackBar(content: Text("Please enter a valid email"));
                              ScaffoldMessenger.of(context).showSnackBar(sn);
                            }

                          }
                          else{
                            // NAME
                            SnackBar sn = SnackBar(content: Text("Please enter a name"));
                            ScaffoldMessenger.of(context).showSnackBar(sn);
                          }
                          
                        }) : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 25, height: 25, child: CircularProgressIndicator(),),
                          ],
                        ),
                  ),
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
