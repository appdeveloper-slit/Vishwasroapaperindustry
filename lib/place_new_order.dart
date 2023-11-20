import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart';
import 'package:vpi/colors.dart';
import 'package:vpi/globalurls.dart';
import 'package:vpi/home_page.dart';
import 'package:vpi/signup.dart';
// import 'package:validators/sanitizers.dart';
// import 'package:validators/validators.dart';

class PlaceNewOrderScreen extends StatefulWidget {
  // final squality;
  final quality;
  final length;
  final width;
  final gsm;
  final isworker;
  const PlaceNewOrderScreen(
      {super.key,
      this.quality,
      this.length,
      this.gsm,
      this.isworker,
      this.width});
@override
  State<PlaceNewOrderScreen> createState() => _PlaceNewOrderScreenState();
}

class _PlaceNewOrderScreenState extends State<PlaceNewOrderScreen> {

  TextEditingController qualityController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController widthController = TextEditingController();
  TextEditingController gsmController = TextEditingController();
  TextEditingController deliveryAddress = TextEditingController();
  bool loading = true;

  void initState() {
    qualityController.text = widget.quality.toString();
    lengthController.text = widget.length.toString();
    widthController.text = widget.width.toString();
    gsmController.text = widget.gsm.toString();
  }

  void placeOrder() async {
    setState(() {
      loading = false;
    });
    print(deliveryAddress.text);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var dio = Dio();
    var formdata = FormData.fromMap({
      'user_id': prefs.getString('user_id'),
      // 'quality': widget.isworker == false ? '' : qualityController.text.toString(),
      'quality': qualityController.text.toString(),

      'width': widthController.text.toString(),
      'length': lengthController.text.toString(),
      'gsm': gsmController.text.toString(),
      'address': deliveryAddress.text.toString(),
    });
    print(formdata.fields);
    final response = await dio.post(placeOrderUrl(), data: formdata);
    var result = response.data;
    print(result);

    setState(() {
      loading = true;
    });

    if (result['success'] == true) {
      print("Order Placed");

      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Success",
                      style: TextStyle(color: Colors.green, fontSize: 18)),
                  Text("Order Placed!"),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => HomeScreen()));
                    },
                    child: Text("OK"))
              ],
            );
          });
    } else {
      print("not able to place order");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Place New Order"),
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
                      widget.isworker == false
                          ? Container()
                          : Align(
                              child: Container(
                                margin: EdgeInsets.only(left: 5),
                                child: Text(
                                  "Quality",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                      widget.isworker == false
                          ? Container()
                          : TextFormField(
                              // maxLength: 10,
                              // keyboardType: TextInputType.number,
                              // controller: loginMobileNumber,
                              enabled: false,
                              controller: qualityController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                // hintText: "Enter Your Number",
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
                        child: Row(
                          children: [
                            Align(
                              child: Container(
                                margin: EdgeInsets.only(left: 5),
                                child: Text(
                                  "Length",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            SizedBox(
                              width: 100,
                            ),
                            Align(
                              child: Container(
                                margin: EdgeInsets.only(left: 5),
                                child: Text(
                                  "Width",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(children: [
                          SizedBox(
                            width: 120,
                            child: TextFormField(
                              controller: lengthController,
                              // maxLength: 10,
                              // keyboardType: TextInputType.number,
                              // controller: loginMobileNumber,
                              enabled: false,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                // hintText: "Enter Your Number",
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
                          SizedBox(
                            width: 35,
                          ),
                          SizedBox(
                            width: 120,
                            child: TextFormField(
                              controller: widthController,
                              enabled: false,
                              // maxLength: 10,
                              // keyboardType: TextInputType.number,
                              // controller: loginMobileNumber,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                // hintText: "Enter Your Number",
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
                        ]),
                      ),
                      SizedBox(height: 25),
                      Align(
                        child: Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text(
                            "GSM",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                      TextFormField(
                        controller: gsmController,
                        // maxLength: 10,
                        // keyboardType: TextInputType.number,
                        // controller: loginMobileNumber,
                        enabled: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          // hintText: "Enter Your Number",
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
                            "Delivery Address",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                      TextFormField(
                        // maxLength: 10,
                        controller: deliveryAddress,
                        // enabled:false,
                        // keyboardType: TextInputType.number,
                        // controller: loginMobileNumber,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          // hintText: "Enter Your Number",
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
                      loading
                          ? SizedBox(
                              width: 100,
                              child: ElevatedButton(
                                  child: Text("Submit"),
                                  onPressed: () {
                                    if (isLength(
                                        deliveryAddress.text.toString(), 5)) {
                                      placeOrder();
                                    } else {
                                      SnackBar sn = SnackBar(
                                          content: Text(
                                              "Delivery address must be 5 characters long..."));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(sn);
                                    }
                                  }),
                            )
                          : Center(child: CircularProgressIndicator()),
                      SizedBox(height: 15),
                    ],
                  )),
            ),
          ],
        ));
  }
}
