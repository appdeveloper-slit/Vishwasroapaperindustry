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

class SignUpFurtherScreen extends StatefulWidget {
  String mobileNumber;
  SignUpFurtherScreen({required this.mobileNumber});
  @override
  State<SignUpFurtherScreen> createState() => SignUpFurtherScreenState(mobileNumber: mobileNumber);
}

class SignUpFurtherScreenState extends State<SignUpFurtherScreen> {
  String mobileNumber;
  SignUpFurtherScreenState({required this.mobileNumber});


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
                  SizedBox(
                  height: 30,
                  ),

                  Column(
                    children: [
                      Text(
                        "Create Account",
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
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
                        controller: signupName,
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
                            "Email ID (Optional)",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                      TextFormField(
                        // maxLength: 10,
                        keyboardType: TextInputType.emailAddress,
                        controller: signupEmail,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Your Email ID",
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
                            "Company Name",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                      TextFormField(
                        // maxLength: 10,
                        // keyboardType: TextInputType.number,
                        controller: signupCompanyName,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Your Company Name",
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
                        child: Text("Register"),
                        onPressed: () async {




                          if(isLength(signupName.text.toString(), 1)){
                            if((signupEmail.text.isNotEmpty && isEmail(signupEmail.text.toString()) || signupEmail.text.isEmpty)){
                              if(isLength(signupCompanyName.text.toString(), 1)){

// Signup API



                  
                            if(isLength(mobileNumber.toString(), 10)){
setState(() {
                            sendload = false;  
                          });

                              var dio = Dio();
                              var formdata = FormData.fromMap({
                                'name' : signupName.text.toString(),
                                'email' : signupEmail.text.toString(),
                                'mobile' : mobileNumber.toString(),
                                'company_name' : signupCompanyName.text.toString(),
                              });
                              final response = await dio.post(register(), data: formdata);
                              var result = response.data;
                              print(result);

                              

                              setState(() {
                            sendload = true;  
                          });

                              if(result['success'] == true){
                                
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                prefs.setBool('isLoggedIn', true);
                                prefs.setString('user_id', result["user_id"].toString());

                                SnackBar sn = new SnackBar(content: Text(result['message'].toString()));
                                ScaffoldMessenger.of(context).showSnackBar(sn);
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => HomeScreen())));
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








                              }
                              else{
                                SnackBar sn = new SnackBar(content: Text("Please enter a company name"));
                            ScaffoldMessenger.of(context).showSnackBar(sn);
                              }
                            }
                            else{
                              SnackBar sn = new SnackBar(content: Text("Email invalid"));
                            ScaffoldMessenger.of(context).showSnackBar(sn);
                            }
                          }
                          else{
                            SnackBar sn = new SnackBar(content: Text("Please enter a name"));
                            ScaffoldMessenger.of(context).showSnackBar(sn);
                          }
                          
                          // login();
                          print("Name: " + signupName.text.toString());
                          print("Email: " + signupEmail.text.toString());
                          print("Company: " + signupCompanyName.text.toString());
                          print("Number: " + mobileNumber.toString());

                        
                          
                        }) : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(child: CircularProgressIndicator()),
                          ],
                        ),
                  ),
                  SizedBox(height: 15),
                  // InkWell(
                  //   onTap: () {
                  //     print("Login tapped");
                  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  //   },
                  //   child: RichText(
                  //       text: TextSpan(
                  //           text: "",
                  //           children: [
                  //             TextSpan(text: "Already have an account? "),
                  //             TextSpan(
                  //               text: "Login",
                  //               style: TextStyle(
                  //                   color: blue, fontWeight: FontWeight.w600),
                  //             ),
                  //           ],
                  //           style: TextStyle(color: Colors.black))),
                  // ),
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
              )]),
        ),
        )],
    ));
  }
}









// Further user form

// Visibility(
//                     visible: !isSubmit,
//                     child: Column(
//                       children: [
//                         Text(
//                           "Create Account",
//                           style: TextStyle(
//                             fontSize: 30,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 30,
//                         ),
//                         Align(
//                           child: Container(
//                             margin: EdgeInsets.only(left: 5),
//                             child: Text(
//                               "Name",
//                               style: TextStyle(
//                                   fontSize: 16, fontWeight: FontWeight.w400),
//                             ),
//                           ),
//                           alignment: Alignment.centerLeft,
//                         ),
//                         TextFormField(
//                           // maxLength: 10,
//                           // keyboardType: TextInputType.number,
//                           controller: signupName,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             hintText: "Enter Your Name",
//                             filled: true,
//                             counterText: "",
//                             contentPadding: EdgeInsets.symmetric(
//                                 vertical: 14, horizontal: 12),
//                             fillColor: Colors.grey[100],
//                             // prefixIcon: Icon(Icons.phone_in_talk_outlined, size: 30, color: blue,),
//                             // prefixIconColor:blue
//                           ),
//                         ),
//                         SizedBox(height: 25),
//                         Align(
//                           child: Container(
//                             margin: EdgeInsets.only(left: 5),
//                             child: Text(
//                               "Email (Optional)",
//                               style: TextStyle(
//                                   fontSize: 16, fontWeight: FontWeight.w400),
//                             ),
//                           ),
//                           alignment: Alignment.centerLeft,
//                         ),
//                         TextFormField(
//                           // maxLength: 10,
//                           keyboardType: TextInputType.emailAddress,
//                           controller: signupEmail,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             hintText: "Enter Your Email",
//                             filled: true,
//                             counterText: "",
//                             contentPadding: EdgeInsets.symmetric(
//                                 vertical: 14, horizontal: 12),
//                             fillColor: Colors.grey[100],
//                             // prefixIcon: Icon(Icons.phone_in_talk_outlined, size: 30, color: blue,),
//                             // prefixIconColor:blue
//                           ),
//                         ),
//                         SizedBox(height: 25),
//                         Align(
//                           child: Container(
//                             margin: EdgeInsets.only(left: 5),
//                             child: Text(
//                               "Company",
//                               style: TextStyle(
//                                   fontSize: 16, fontWeight: FontWeight.w400),
//                             ),
//                           ),
//                           alignment: Alignment.centerLeft,
//                         ),
//                         TextFormField(
//                           // maxLength: 10,
//                           // keyboardType: TextInputType.number,
//                           controller: signupCompanyName,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             hintText: "Enter Your Company Name",
//                             filled: true,
//                             counterText: "",
//                             contentPadding: EdgeInsets.symmetric(
//                                 vertical: 14, horizontal: 12),
//                             fillColor: Colors.grey[100],
//                             // prefixIcon: Icon(Icons.phone_in_talk_outlined, size: 30, color: blue,),
//                             // prefixIconColor:blue
//                           ),
//                         ),
//                         SizedBox(height: 25),
//                       ],
//                     ),
//                   ),


// // user submit button
//                   SizedBox(
//                     width: 130,
//                     child: ElevatedButton(
//                         child: Text("Submit"),
//                         onPressed: () {
//                           if(isLength(signupName.text.toString(), 3)){
//                             if(isEmail(signupEmail.text.toString())){
//                               if(isLength(signupCompanyName.text.toString(), 3)){
//                               }
//                               else{
//                                 SnackBar sn = new SnackBar(content: Text("Company name must be at least 3 characters"));
//                             ScaffoldMessenger.of(context).showSnackBar(sn);
//                               }
//                             }
//                             else{
//                               SnackBar sn = new SnackBar(content: Text("Email invalid"));
//                             ScaffoldMessenger.of(context).showSnackBar(sn);
//                             }
//                           }
//                           else{
//                             SnackBar sn = new SnackBar(content: Text("Name must be at least 3 characters"));
//                             ScaffoldMessenger.of(context).showSnackBar(sn);
//                           }


                          
//                         }),
//                   ),



// user register api call

//  Visibility(
//                     visible: isSubmit,
//                     child: SizedBox(
//                       width: 130,
//                       child: sendload ? ElevatedButton(
//                           child: Text("Register"),
//                           onPressed: () async {
                            
//                             // login();
//                             print("Name: " + signupName.text.toString());
//                             print("Email: " + signupEmail.text.toString());
//                             print("Company: " + signupCompanyName.text.toString());
//                             print("Number: " + signupNumber.text.toString());

//                             if(isLength(signupNumber.text.toString(), 10)){
// setState(() {
//                             sendload = false;  
//                           });

//                               var dio = Dio();
//                               var formdata = FormData.fromMap({
//                                 'name' : signupNumber.text.toString(),
//                                 'email' : signupEmail.text.toString(),
//                                 'mobile' : signupNumber.text.toString(),
//                                 'company_name' : signupCompanyName.text.toString(),
//                               });
//                               final response = await dio.post(register(), data: formdata);
//                               var result = response.data;
//                               print(result);

//                               setState(() {
//                             sendload = true;  
//                           });

//                               if(result['success'] == true){
//                                 SnackBar sn = new SnackBar(content: Text(result['message'].toString()));
//                                 ScaffoldMessenger.of(context).showSnackBar(sn);
//                                 Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => LoginScreen())));
//                               }
//                               else{
//                                 SnackBar sn = new SnackBar(content: Text(result['message'].toString()));
//                                 ScaffoldMessenger.of(context).showSnackBar(sn);
//                               }
//                             }
//                             else{
//                               SnackBar sn = new SnackBar(content: Text("Number must be 10 digits long"));
//                                 ScaffoldMessenger.of(context).showSnackBar(sn);
//                             }

                            
//                           }) : Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Center(child: CircularProgressIndicator()),
//                             ],
//                           ),
//                     ),
//                   ),