import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vpi/colors.dart';
import 'package:vpi/signup.dart';
// import 'package:validators/sanitizers.dart';
// import 'package:validators/validators.dart';

class BankDetailsScreen extends StatefulWidget {
  const BankDetailsScreen({Key? key}) : super(key: key);
  @override
  State<BankDetailsScreen> createState() => BankDetailsScreenState();
}

class BankDetailsScreenState extends State<BankDetailsScreen> {
  TextEditingController loginMobileNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bank Details"), centerTitle: true,),
        body: ListView(
      children: [
        Center(
          child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(20),
              child: Column(
                children: [
                  Align(
                    child: Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Text(
                        "Bank Name",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    padding: EdgeInsets.all(10),
                    color: Colors.grey[200],
                    width: MediaQuery.of(context).size.width,
                    child: Align(child: Text("Union Bank of India",style: TextStyle(
                            fontSize: 16,),), alignment: Alignment.centerLeft,),
                  ),
                  SizedBox(height: 20,),
                  Align(
                    child: Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Text(
                        "Account Number",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    padding: EdgeInsets.all(10),
                    color: Colors.grey[200],
                    width: MediaQuery.of(context).size.width,
                    child: Align(child: Text("315801010036798",style: TextStyle(
                            fontSize: 16,),), alignment: Alignment.centerLeft,),
                  ),
                  SizedBox(height: 20,),
                  Align(
                    child: Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Text(
                        "Linked Mobile Number",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    padding: EdgeInsets.all(10),
                    color: Colors.grey[200],
                    width: MediaQuery.of(context).size.width,
                    child: Align(child: Text("7021455883",style: TextStyle(
                            fontSize: 16,),), alignment: Alignment.centerLeft,),
                  ),
                  SizedBox(height: 20,),
                  Align(
                    child: Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Text(
                        "IFSC Code",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    padding: EdgeInsets.all(10),
                    color: Colors.grey[200],
                    width: MediaQuery.of(context).size.width,
                    child: Align(child: Text("UBIN0531588",style: TextStyle(
                            fontSize: 16,),), alignment: Alignment.centerLeft,),
                  ),
                  SizedBox(height: 20,),
                  Align(
                    child: Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Text(
                        "Account Holder Name",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    padding: EdgeInsets.all(10),
                    color: Colors.grey[200],
                    width: MediaQuery.of(context).size.width,
                    child: Align(child: Text("VISHWAS PAPER INDUSTRIES",style: TextStyle(
                            fontSize: 16,),), alignment: Alignment.centerLeft,),
                  ),
                ],
              )),
        ),
      ],
    ));
  }
}
