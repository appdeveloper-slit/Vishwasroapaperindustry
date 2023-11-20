import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

// import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:vpi/aboutus.dart';
import 'package:vpi/bank_details.dart';
import 'package:vpi/colors.dart';
import 'package:vpi/contactus.dart';
import 'package:vpi/feedback.dart';
import 'package:vpi/globalurls.dart';
import 'package:vpi/login.dart';
import 'package:vpi/my_profile.dart';
import 'package:vpi/notification.dart';
import 'package:vpi/paperdescription.dart';
import 'package:vpi/place_new_order.dart';
import 'package:vpi/privacypolicy.dart';
import 'package:vpi/signup.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:share_plus/share_plus.dart';

// import 'package:validators/sanitizers.dart';
// import 'package:validators/validators.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

// List<String> imgList = [];
//
// List<Widget> imageSliders = imgList
//     .map((item) => Container(
//           child: Container(
//             margin: EdgeInsets.all(5.0),
//             child: ClipRRect(
//                 borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                 child: Stack(
//                   children: <Widget>[
//                     CachedNetworkImage(
//                         imageUrl: item, fit: BoxFit.cover, width: 500.0),
//                     Positioned(
//                       bottom: 0.0,
//                       left: 0.0,
//                       right: 0.0,
//                       child: Container(
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [
//                               Color.fromARGB(0, 0, 0, 0),
//                               Color.fromARGB(0, 0, 0, 0)
//                             ],
//                             begin: Alignment.bottomCenter,
//                             end: Alignment.topCenter,
//                           ),
//                         ),
//                         padding: EdgeInsets.symmetric(
//                             vertical: 10.0, horizontal: 10.0),
//                         child: Text(
//                           '',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20.0,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 )),
//           ),
//         ))
//     .toList();

class HomeScreenState extends State<HomeScreen> {
  int selected = 0;
  bool homeloaded = false;
  final CarouselController _controller = CarouselController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController widthController = TextEditingController();
  TextEditingController gsmController = TextEditingController();
  String dropdownvalue = '';
  bool isTableLoaded = false;
  var productGroupDropDown = [];
  List productGroupData = [];
  var isWorker;
  String currentProductGroupData = "-";
  List<TableRow> list_of_rows = [];
  String timetaken = '';
  bool firstSearch = false;
  String profileName = '';
  DateTime? currentBackPressTime;
  bool? isProfileStatus;
  bool ischeck = false;

  // Widget sliderwidget() {
  //   return CarouselSlider(
  //     items: imageSliders,
  //     carouselController: _controller,
  //     options: CarouselOptions(
  //         autoPlay: false,
  //         enlargeCenterPage: false,
  //         // aspectRatio: 3.0,
  //         viewportFraction: 1.0,
  //         height: 200,
  //         onPageChanged: (index, reason) {
  //           setState(() {
  //             selected = index;
  //           });
  //         }),
  //   );
  // }

  // Widget dots() {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(
  //       vertical: 4,
  //       horizontal: 12,
  //     ),
  //     child: Wrap(
  //       children: imgList.asMap().entries.map((entry) {
  //         return Container(
  //           width: 12,
  //           height: 12,
  //           margin: const EdgeInsets.symmetric(
  //             horizontal: 2,
  //           ),
  //           decoration: BoxDecoration(
  //             shape: BoxShape.circle,
  //             color: selected == entry.key ? blue : Colors.grey[200],
  //             // border: Border.all(width: 2, color: blue),
  //           ),
  //         );
  //       }).toList(),
  //     ),
  //   );
  // }

  Widget groupProductDropDown() {
    return (productGroupDropDown.length > 0)
        ? Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            // decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 2, color: Colors.grey),)),
            child: DropdownButton(
              icon: Icon(Icons.keyboard_arrow_down),
              iconSize: 30,
              iconEnabledColor: blue,
              isExpanded: true,
              items: productGroupDropDown.map((items) {
                return DropdownMenuItem(
                  value: items[1].toString(),
                  child: Text(items[0]),
                );
              }).toList(),
              value: dropdownvalue,
              onChanged: (newValue) {
                print(newValue);
                setState(() {
                  dropdownvalue = newValue.toString();
                  print(dropdownvalue);
                });
              },
            ),
          )
        : Center(child: Text("No Data found"));
  }

  TableRow listRows1(
    String? gsm,
    String? width,
    String? length,
    String? per_bundle_no_of_sheet,
    String? total_sheet,
  ) {
    return TableRow(
      children: [
        // Container(
        //     width: 250,
        //     height: MediaQuery.of(context).size.height / 12,
        //     padding: EdgeInsets.all(10),
        //     decoration: BoxDecoration(border: Border.all(width: 1)),
        //     child: SizedBox(
        //       // height: 18,
        //       child: InkWell(onTap: (){
        //         Navigator.push(context, MaterialPageRoute(builder: ((context) => PlaceNewOrderScreen(quality: quality, length: length, width: width, gsm: gsm))));
        //       }, child: Icon(Icons.shopping_cart),),
        //     )
        //         ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Container(
            padding: EdgeInsets.only(left: 2, right: 2),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: Text(gsm!,
                          maxLines: 10,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 10.0)))
                ]),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Container(
            padding: EdgeInsets.only(left: 2, right: 2),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: Text(length.toString() + " x " + width.toString(),
                          maxLines: 10,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 10.0)))
                ]),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Container(
            padding: EdgeInsets.only(left: 2, right: 2),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: Text(per_bundle_no_of_sheet!,
                          maxLines: 10,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 10.0)))
                ]),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Container(
            padding: EdgeInsets.only(left: 2, right: 2),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: Text(total_sheet!,
                          maxLines: 10,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 10.0)))
                ]),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Container(
            padding: EdgeInsets.only(left: 2, right: 2),
            child: SizedBox(
              // height: 18,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => PlaceNewOrderScreen(
                              isworker: isWorker,
                              length: length!,
                              width: width!,
                              gsm: gsm))));
                },
                child: Icon(
                  Icons.shopping_cart,
                  color: blue,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  TableRow listRows(String? quality, String? gsm, String? width, String? length,
      String? per_bundle_no_of_sheet, String? total_sheet, String? go_down) {
    return TableRow(
      children: [
        // Container(
        //     width: 250,
        //     height: MediaQuery.of(context).size.height / 12,
        //     padding: EdgeInsets.all(10),
        //     decoration: BoxDecoration(border: Border.all(width: 1)),
        //     child: SizedBox(
        //       // height: 18,
        //       child: InkWell(onTap: (){
        //         Navigator.push(context, MaterialPageRoute(builder: ((context) => PlaceNewOrderScreen(quality: quality, length: length, width: width, gsm: gsm))));
        //       }, child: Icon(Icons.shopping_cart),),
        //     )
        //         ),
        isWorker
            ? TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Container(
                  padding: EdgeInsets.only(left: 2, right: 2),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                            alignment: Alignment.center,
                            child: Text(quality!,
                                maxLines: 10,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 10.0)))
                      ]),
                ),
              )
            : Container(),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Container(
            padding: EdgeInsets.only(left: 2, right: 2),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: Text(gsm!,
                          maxLines: 10,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 10.0)))
                ]),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Container(
            padding: EdgeInsets.only(left: 2, right: 2),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: Text(length.toString() + " x " + width.toString(),
                          maxLines: 10,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 10.0)))
                ]),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Container(
            padding: EdgeInsets.only(left: 2, right: 2),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: Text(per_bundle_no_of_sheet!,
                          maxLines: 10,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 10.0)))
                ]),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Container(
            padding: EdgeInsets.only(left: 2, right: 2),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: Text(total_sheet!,
                          maxLines: 10,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 10.0)))
                ]),
          ),
        ),
        isWorker
            ? TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Container(
                  padding: EdgeInsets.only(left: 2, right: 2),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                            alignment: Alignment.center,
                            child: Text(go_down!,
                                maxLines: 10,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 10.0)))
                      ]),
                ),
              )
            : Container(),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Container(
            padding: EdgeInsets.only(left: 2, right: 2),
            child: SizedBox(
              // height: 18,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => PlaceNewOrderScreen(
                              quality: quality!,
                              length: length!,
                              width: width!,
                              gsm: gsm))));
                },
                child: Icon(
                  Icons.shopping_cart,
                  color: blue,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var dio = Dio();
    var formdata = FormData.fromMap({
      'user_id': prefs.getString('user_id'),
    });
    final response = await dio.post(getProfileUrl(), data: formdata);
    var result = response.data;
    print(result);

    if (result['success'] == true) {
      setState(() {
        profileName = result['name'].toString();
      });
    } else {
      setState(() {
        profileName = 'NA';
      });
    }
  }

  void searchTableData() async {
    print(lengthController.text);
    print(widthController.text);
    print(gsmController.text);
    print(dropdownvalue);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isTableLoaded = false;
    });
    firstSearch = true;
    var dio = Dio();
    var formdata = FormData.fromMap({
      'user_id': prefs.getString('user_id'),
      'quality': dropdownvalue.toString(),
      'width': widthController.text.toString(),
      'length': lengthController.text.toString(),
      'gsm': gsmController.text.toString(),
      'ranges': numberchange,
      'range1': numberchange1,
    });
    final response = await dio.post(getHomeDataUrl(), data: formdata);
    var result = response.data;
    print(result);
    // print(response.data['slider_array']);

    list_of_rows = [];
    setState(() {
      isWorker = result['is_worker'];
    });
    for (int i = 0; i < result['result_array'].length; i++) {
      if (result['is_worker'] == true) {
        list_of_rows.add(listRows(
            result['result_array'][i]['quality'].toString(),
            result['result_array'][i]['gsm'].toString(),
            result['result_array'][i]['size_to'].toString(),
            // width
            result['result_array'][i]['size_from'].toString(),
            // length
            result['result_array'][i]['per_bundle_sheet'].toString(),
            result['result_array'][i]['total_sheet'].toString(),
            result['result_array'][i]['name'].toString()));
      } else {
        list_of_rows.add(listRows1(
            result['result_array'][i]['gsm'].toString(),
            result['result_array'][i]['size_to'].toString(),
            // width
            result['result_array'][i]['size_from'].toString(),
            // length
            result['result_array'][i]['per_bundle_sheet'].toString(),
            result['result_array'][i]['total_sheet'].toString()));
      }
      // list_of_rows.add(listRows(
      //        result['result_array'][i]['quality'].toString(),
      //       result['result_array'][i]['gsm'].toString(),
      //       result['result_array'][i]['size_to'].toString(),
      //       // width
      //       result['result_array'][i]['size_from'].toString(),
      //       // length
      //       result['result_array'][i]['per_bundle_sheet'].toString(),
      //       result['result_array'][i]['total_sheet'].toString(),
      //        result['result_array'][i]['name'].toString()
      //           ));
    }

    timetaken = result['time'].toStringAsExponential(3);

    setState(() {
      firstSearch = firstSearch;
      timetaken = timetaken;
      isTableLoaded = true;
      list_of_rows = list_of_rows;
    });
  }

  void getHomePageData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isTableLoaded = false;
      homeloaded = false;
    });
    var dio = Dio();
    var formdata = FormData.fromMap({
      'user_id': prefs.getString('user_id'),
    });
    final response = await dio.post(getHomeDataUrl(), data: formdata);
    var result = response.data;
    print(result);
    if (result['is_profile_status'] == false) {
      setState(() {
        isProfileStatus = true;
      });
    }
    if (result['is_status'] == false) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', false);
      prefs.setString('user_id', '');

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Status inactive"),
            content: Text("Your account is not active."),
            actions: [
              TextButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: Text("OK"))
            ],
          );
        },
      );
    }
    // print(response.data['slider_array']);

    list_of_rows = [];
    // for (int i = 0; i < result['result_array'].length; i++) {
    //   list_of_rows.add(listRows(
    //       result['result_array'][i]['quality'].toString(),
    //       result['result_array'][i]['gsm'].toString(),
    //       result['result_array'][i]['size_to'].toString(),
    //       result['result_array'][i]['size_from'].toString(),
    //       result['result_array'][i]['per_bundle_sheet'].toString(),
    //       result['result_array'][i]['total_sheet'].toString(),
    //       result['result_array'][i]['name'].toString()));
    // }

    // imgList = [];
    // for (int i = 0; i < result['slider_array'].length; i++) {
    //   imgList.add(result['slider_array'][i]['image']);
    // }

    productGroupDropDown = [];
    for (int i = 0; i < result['quality_array'].length; i++) {
      productGroupDropDown.add([
        result['quality_array'][i]['name'].toString(),
        result['quality_array'][i]['id'].toString()
      ]);
    }
    if (result['quality_array'].length > 0) {
      dropdownvalue = result['quality_array'][0]['id'].toString();
    }
    timetaken = result['time'].toStringAsExponential(3);
    setState(() {
      timetaken = timetaken;
      isTableLoaded = true;
      homeloaded = true;
      list_of_rows = list_of_rows;
      productGroupData = productGroupData;
      // imageSliders = imgList
      //     .map((item) => Container(
      //           child: Container(
      //             margin: EdgeInsets.all(5.0),
      //             child: ClipRRect(
      //                 borderRadius: BorderRadius.all(Radius.circular(5.0)),
      //                 child: Stack(
      //                   children: <Widget>[
      //                     CachedNetworkImage(
      //                         imageUrl: item, fit: BoxFit.cover, width: MediaQuery.of(context).size.width),
      //                     Positioned(
      //                       bottom: 0.0,
      //                       left: 0.0,
      //                       right: 0.0,
      //                       child: Container(
      //                         decoration: BoxDecoration(
      //                           gradient: LinearGradient(
      //                             colors: [
      //                               Color.fromARGB(0, 0, 0, 0),
      //                               Color.fromARGB(0, 0, 0, 0)
      //                             ],
      //                             begin: Alignment.bottomCenter,
      //                             end: Alignment.topCenter,
      //                           ),
      //                         ),
      //                         padding: EdgeInsets.symmetric(
      //                             vertical: 10.0, horizontal: 10.0),
      //                         child: Text(
      //                           '',
      //                           style: TextStyle(
      //                             color: Colors.white,
      //                             fontSize: 20.0,
      //                             fontWeight: FontWeight.bold,
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                   ],
      //                 )),
      //           ),
      //         ))
      //     .toList();
    });
  }

  void checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    print(connectivityResult);
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // Do nothing
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.wifi_off,
                size: 100,
                color: blue,
              ),
              SizedBox(
                height: 15,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text("No internet connection!",
                      style: TextStyle(fontSize: 24))),
            ],
          );
        },
      );

      //  children: [
      //   Icon(Icons.wifi_off),
      //   Text("No internet connection!"),
      // ]);
    }
  }

  @override
  void initState() {
    checkConnectivity();
    getHomePageData();
    getProfile();
    super.initState();
  }

  ScreenshotController sc = ScreenshotController();

  Future saveShare(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final imageFile = File('${directory.path}/screenshot.jpeg');
    imageFile.writeAsBytesSync(bytes);
    String text = "Vishwas Paper Industries";
    await Share.shareFiles([imageFile.path]);
  }

  String? numberchange;
  String? numberchange1;

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: sc,
      child: Scaffold(
          bottomNavigationBar: ischeck == true
              ? InkWell(
                onTap: () {
                  launch("tel://7021455883");
                },
                child: Icon(
                  Icons.phone,
                  color: Colors.blue.shade700,
                  size: 40,
                ),
              )
              : Container(
            height: 0,
          ),
          appBar: isProfileStatus == true
              ? AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                )
              : AppBar(
                  title: Image.asset(
                    "assets/images/logo.png",
                    width: 50,
                    height: 50,
                  ),
                  centerTitle: true,
                  leading: Builder(
                    builder: (BuildContext context) {
                      return IconButton(
                        icon: const Icon(Icons.sort_rounded),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        tooltip: "OPEN MENU",
                      );
                    },
                  ),
                  actions: [
                    IconButton(
                        onPressed: () async {
                          final image = await sc.capture();
                          saveShare(image!);
                        },
                        icon: Icon(Icons.share))
                  ],
                ),
          drawer: isProfileStatus == true
              ? null
              : Container(
                  width: 250,
                  child: Drawer(
                      child: ListView(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        child: Image.asset(
                          "assets/images/logo.png",
                        ),
                        width: 120.0,
                        height: 120,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        child: Text(
                          profileName,
                          style: TextStyle(fontSize: 18),
                        ),
                        alignment: Alignment.center,
                      ),
                      Container(
                        child: Divider(
                          height: 10,
                          color: Colors.grey,
                          thickness: 2,
                        ),
                        margin: EdgeInsets.all(10),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.person_outline_rounded,
                          color: blue,
                        ),
                        title: Text("My Profile"),
                        onTap: () {
                          // Do something...
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MyProfileScreen()));
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.notifications_outlined,
                          color: blue,
                        ),
                        title: Text("Notifications"),
                        onTap: () {
                          // Do something...
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => NotificationsScreen()));
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.content_paste_outlined,
                          color: blue,
                        ),
                        title: Text("Find Nearest Size"),
                        onTap: () {
                          // Do something...
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.padding_outlined,
                          color: blue,
                        ),
                        title: Text("Paper Description"),
                        onTap: () {
                          // Do something...
                          // Navigator.pop(context);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PaperDescription()));
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.account_balance_outlined,
                          color: blue,
                        ),
                        title: Text("Bank Details"),
                        onTap: () {
                          // Do something...
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BankDetailsScreen()));
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.feedback_outlined,
                          color: blue,
                        ),
                        title: Text("Feedback"),
                        onTap: () {
                          // Do something...
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => FeedbackScreen()));
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.phone_in_talk_outlined,
                          color: blue,
                        ),
                        title: Text("Contact Us"),
                        onTap: () {
                          // Do something...
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ContactUsScreen()));
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.info_outline,
                          color: blue,
                        ),
                        title: Text("About Us"),
                        onTap: () {
                          // Do something...
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AboutUsScreen()));
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.privacy_tip_outlined,
                          color: blue,
                        ),
                        title: Text("Privacy Policy"),
                        onTap: () async {
                          // Do something...
                          if (!await launchUrlString(
                              "https://vishwaspaperindustries.in/privacy.php",
                              webOnlyWindowName: "Privacy Policy",
                              mode: LaunchMode.externalApplication,
                              webViewConfiguration: WebViewConfiguration()))
                            throw 'Could not launch';
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => PrivacyPolicyScreen()));
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.share_outlined,
                          color: blue,
                        ),
                        title: Text("Share"),
                        onTap: () {
                          Share.share(
                              'Download The Vishwas Paper Industries App \n\nhttps://play.google.com/store/apps/details?id=com.app.vishwas_paper_industries&hl=en');
                          // Do something...
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.logout_outlined,
                          color: blue,
                        ),
                        title: Text("Logout"),
                        onTap: () async {
                          // Do something...
                          SharedPreferences sp =
                              await SharedPreferences.getInstance();
                          sp.setBool("isLoggedIn", false);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                      ),
                    ],
                  )),
                ),
          // resizeToAvoidBottomInset: false,
          // floatingActionButton: ischeck == true
          //     ? Padding(
          //         padding: const EdgeInsets.only(bottom: 40.0),
          //         child: InkWell(
          //           onTap: () {
          //             launch("tel://7021455883");
          //           },
          //           child: Container(
          //               height: 50.0,
          //               width: 50.0,
          //               decoration: BoxDecoration(
          //                   color: Colors.white, shape: BoxShape.circle),
          //               child: Icon(
          //                 Icons.phone,
          //                 color: Colors.blue.shade700,
          //                 size: 40,
          //               )),
          //         ),
          //       )
          //     : Container(),
          // floatingActionButtonLocation:
          //     FloatingActionButtonLocation.centerFloat,
          body:
          isProfileStatus == true
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Your account is under review so please wait or contact us...',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      SizedBox(
                        width: 160.0,
                        height: 50.0,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ContactUsScreen()),
                              );
                            },
                            child: Center(
                              child: Text('Contact US',
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.white)),
                            )),
                      )
                    ],
                  ),
                )
              : homeloaded
                  ? WillPopScope(
                      onWillPop: () {
                        DateTime now = DateTime.now();
                        if (currentBackPressTime == null ||
                            now.difference(currentBackPressTime!) >
                                Duration(seconds: 2)) {
                          currentBackPressTime = now;
                          SnackBar sn = SnackBar(
                            content: Text("Press back again to exit"),
                            duration: Duration(milliseconds: 500),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(sn);
                          return Future.value(false);
                        }
                        return Future.value(true);
                      },
                      child: UpgradeAlert(
                        upgrader:
                            Upgrader(dialogStyle: UpgradeDialogStyle.material),
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            SizedBox(
                              height: 20.0,
                            ),
                            Center(
                              child: Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.all(5),
                                  child: Column(
                                    children: [
                                      // sliderwidget(),
                                      Text("Find Nearest Size",
                                          style: TextStyle(
                                              color: blue,
                                              fontSize: 25,
                                              fontWeight: FontWeight.w700)),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Align(
                                            child: Container(
                                              margin: EdgeInsets.only(left: 5),
                                              child: Text(
                                                "Select Product Group",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                            alignment: Alignment.centerLeft,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Center(child: groupProductDropDown()),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                width: 100,
                                                margin:
                                                    EdgeInsets.only(left: 5),
                                                child: TextFormField(
                                                  decoration: InputDecoration(
                                                      hintText: 'Length (inch)',
                                                      hintStyle: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                  controller: lengthController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          left: 5),
                                                      child: IconButton(
                                                        icon: Icon(
                                                          Icons
                                                              .swap_horiz_outlined,
                                                          color: blue,
                                                          size: 40,
                                                        ),
                                                        onPressed: () {
                                                          // Swap data
                                                          String swapper =
                                                              lengthController
                                                                  .text
                                                                  .toString();
                                                          lengthController
                                                                  .text =
                                                              widthController
                                                                  .text
                                                                  .toString();
                                                          widthController.text =
                                                              swapper
                                                                  .toString();
                                                        },
                                                      )),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 5, top: 10.0),
                                                    child: Icon(
                                                      Icons.close,
                                                      color: blue,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                width: 110,
                                                margin:
                                                    EdgeInsets.only(left: 5),
                                                child: TextFormField(
                                                  decoration: InputDecoration(
                                                    hintText: 'Width (inch)',
                                                    hintStyle: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  controller: widthController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                width: 110.0,
                                                // margin: EdgeInsets.only(left: MediaQuery.of(context).size.width / 3),
                                                child: TextFormField(
                                                  decoration: InputDecoration(
                                                      hintText: "GSM",
                                                      hintStyle: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                  controller: gsmController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                              Center(
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Container(
                                                    // margin: EdgeInsets.only(left: 120),
                                                    child: Text(
                                                      "OR",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        width: 110.0,
                                                        child:
                                                            DropdownButtonFormField<
                                                                String>(
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                numberchange ??
                                                                    'Extra',
                                                          ),
                                                          isExpanded: true,
                                                          value: numberchange,
                                                          items: <String>[
                                                            '0',
                                                            '1',
                                                            '2',
                                                            '3',
                                                            '4',
                                                            '5',
                                                          ].map((String value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child:
                                                                  Text(value),
                                                            );
                                                          }).toList(),
                                                          onChanged: (value) {
                                                            setState(() {
                                                              numberchange =
                                                                  value!;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 28.0,
                                                      vertical: 12.0),
                                              child: Container(
                                                width: 100.0,
                                                child: DropdownButtonFormField<
                                                    String>(
                                                  decoration: InputDecoration(
                                                      hintText: numberchange1 ??
                                                          'Multiple'),
                                                  isExpanded: true,
                                                  value: numberchange1,
                                                  items: <String>[
                                                    '1',
                                                    '2',
                                                    '3',
                                                    '4',
                                                    '5',
                                                    '6',
                                                    '7',
                                                    '8',
                                                    '9',
                                                  ].map((String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      numberchange1 = value!;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          SizedBox(
                                            width: 140,
                                            child: ElevatedButton(
                                                child: Row(
                                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(Icons
                                                          .search_outlined),
                                                      Text("Search")
                                                    ]),
                                                onPressed: () {
                                                  // login();
                                                  setState(() {
                                                    ischeck = true;
                                                  });
                                                  searchTableData();
                                                }),
                                          ),
                                          SizedBox(
                                            width: 140,
                                            child: OutlinedButton(
                                                child: Row(
                                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(Icons.sync_outlined),
                                                      Text("Reverse")
                                                    ]),
                                                onPressed: () {
                                                  String swapper =
                                                      lengthController.text
                                                          .toString();
                                                  lengthController.text =
                                                      widthController.text
                                                          .toString();
                                                  widthController.text =
                                                      swapper.toString();
                                                }),
                                          ),
                                        ],
                                      ),
                                      // SizedBox(
                                      //   height: 15,
                                      // ),
                                      // Align(
                                      //   child: Text(
                                      //     timetaken,
                                      //     style: TextStyle(color: Colors.grey),
                                      //   ),
                                      //   alignment: Alignment.centerLeft,
                                      // ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      isTableLoaded
                                          ? list_of_rows.length > 0
                                              ? isWorker == true
                                                  ? Table(
                                                      // scrollDirection: Axis.horizontal,
                                                      border: TableBorder.all(
                                                          color: Colors.grey,
                                                          style:
                                                              BorderStyle.solid,
                                                          width: 2),
                                                      children: [
                                                          // list_of_rows.length > 0 ?
                                                          TableRow(
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            224,
                                                                            224,
                                                                            224)),
                                                            children: [
                                                              TableCell(
                                                                verticalAlignment:
                                                                    TableCellVerticalAlignment
                                                                        .middle,
                                                                child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Container(
                                                                        // color: Colors.grey[100],
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                2,
                                                                            right:
                                                                                2),
                                                                        child: Align(
                                                                            alignment: Alignment
                                                                                .center,
                                                                            child: Text('Quality',
                                                                                maxLines: 5,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold))),
                                                                      )
                                                                    ]),
                                                              ),
                                                              TableCell(
                                                                verticalAlignment:
                                                                    TableCellVerticalAlignment
                                                                        .middle,
                                                                child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Container(
                                                                        // color: Colors.grey[100],
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                2,
                                                                            right:
                                                                                2),
                                                                        child: Align(
                                                                            alignment: Alignment
                                                                                .center,
                                                                            child: Text('GSM',
                                                                                maxLines: 5,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold))),
                                                                      )
                                                                    ]),
                                                              ),
                                                              TableCell(
                                                                verticalAlignment:
                                                                    TableCellVerticalAlignment
                                                                        .middle,
                                                                child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Container(
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                2,
                                                                            right:
                                                                                2),
                                                                        // color: Colors.grey[100],
                                                                        child: Align(
                                                                            alignment: Alignment
                                                                                .center,
                                                                            child: Text('Size In Inch',
                                                                                textAlign: TextAlign.center,
                                                                                maxLines: 5,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold))),
                                                                      )
                                                                    ]),
                                                              ),
                                                              TableCell(
                                                                verticalAlignment:
                                                                    TableCellVerticalAlignment
                                                                        .middle,
                                                                child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Container(
                                                                        padding:
                                                                            EdgeInsets.only(
                                                                          top:
                                                                              4,
                                                                          bottom:
                                                                              4,
                                                                          left:
                                                                              2,
                                                                          right:
                                                                              2,
                                                                        ),
                                                                        // color: Colors.grey[100],
                                                                        child: Align(
                                                                            alignment: Alignment
                                                                                .center,
                                                                            child: Text('Per Bundle No. of Sheet',
                                                                                maxLines: 5,
                                                                                textAlign: TextAlign.center,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: TextStyle(height: 1.1, fontSize: 12.0, fontWeight: FontWeight.bold))),
                                                                      )
                                                                    ]),
                                                              ),
                                                              TableCell(
                                                                verticalAlignment:
                                                                    TableCellVerticalAlignment
                                                                        .middle,
                                                                child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Container(
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                2,
                                                                            right:
                                                                                2),
                                                                        // color: Colors.grey[100],
                                                                        child: Align(
                                                                            alignment: Alignment
                                                                                .center,
                                                                            child: Text('Total sheets',
                                                                                maxLines: 5,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold))),
                                                                      )
                                                                    ]),
                                                              ),
                                                              TableCell(
                                                                verticalAlignment:
                                                                    TableCellVerticalAlignment
                                                                        .middle,
                                                                child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Container(
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                2,
                                                                            right:
                                                                                2),
                                                                        // color: Colors.grey[100],
                                                                        child: Align(
                                                                            alignment: Alignment
                                                                                .center,
                                                                            child: Text('Go-down',
                                                                                maxLines: 5,
                                                                                textAlign: TextAlign.center,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold))),
                                                                      )
                                                                    ]),
                                                              ),
                                                              TableCell(
                                                                verticalAlignment:
                                                                    TableCellVerticalAlignment
                                                                        .middle,
                                                                child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Container(
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                2,
                                                                            right:
                                                                                2),
                                                                        // color: Colors.grey[100],
                                                                        child: Align(
                                                                            alignment: Alignment
                                                                                .center,
                                                                            child: Text('Order',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold))),
                                                                      )
                                                                    ]),
                                                              )
                                                            ],
                                                          ),
                                                          // : firstSearch ? Text("Nothing found...") : Text(""),
                                                          // list_of_rows.length > 0 ? Column(
                                                          //   children: list_of_rows,
                                                          // ) : Text(""),

                                                          // for(int i =0; i<list_of_rows.length; i++) list_of_rows[i]
                                                        ])
                                                  : Table(
                                                      // scrollDirection: Axis.horizontal,
                                                      border: TableBorder.all(
                                                          color: Colors.grey,
                                                          style:
                                                              BorderStyle.solid,
                                                          width: 2),
                                                      children: [
                                                          // list_of_rows.length > 0 ?
                                                          TableRow(
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            224,
                                                                            224,
                                                                            224)),
                                                            children: [
                                                              TableCell(
                                                                verticalAlignment:
                                                                    TableCellVerticalAlignment
                                                                        .middle,
                                                                child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Container(
                                                                        // color: Colors.grey[100],
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                2,
                                                                            right:
                                                                                2),
                                                                        child: Align(
                                                                            alignment: Alignment
                                                                                .center,
                                                                            child: Text('GSM',
                                                                                maxLines: 5,
                                                                                textAlign: TextAlign.center,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold))),
                                                                      )
                                                                    ]),
                                                              ),
                                                              TableCell(
                                                                verticalAlignment:
                                                                    TableCellVerticalAlignment
                                                                        .middle,
                                                                child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Container(
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                2,
                                                                            right:
                                                                                2),
                                                                        // color: Colors.grey[100],
                                                                        child: Align(
                                                                            alignment: Alignment
                                                                                .center,
                                                                            child: Text('Size In Inch',
                                                                                maxLines: 5,
                                                                                textAlign: TextAlign.center,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold))),
                                                                      )
                                                                    ]),
                                                              ),
                                                              TableCell(
                                                                verticalAlignment:
                                                                    TableCellVerticalAlignment
                                                                        .middle,
                                                                child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Container(
                                                                        padding: EdgeInsets.only(
                                                                            top:
                                                                                4,
                                                                            bottom:
                                                                                4,
                                                                            left:
                                                                                2,
                                                                            right:
                                                                                2),
                                                                        // color: Colors.grey[100],
                                                                        child: Align(
                                                                            alignment: Alignment
                                                                                .center,
                                                                            child: Text('Per Bundle No. of Sheet',
                                                                                maxLines: 5,
                                                                                textAlign: TextAlign.center,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold))),
                                                                      )
                                                                    ]),
                                                              ),
                                                              TableCell(
                                                                verticalAlignment:
                                                                    TableCellVerticalAlignment
                                                                        .middle,
                                                                child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Container(
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                2,
                                                                            right:
                                                                                2),
                                                                        // color: Colors.grey[100],
                                                                        child: Align(
                                                                            alignment: Alignment
                                                                                .center,
                                                                            child: Text('Total sheets',
                                                                                maxLines: 5,
                                                                                textAlign: TextAlign.center,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold))),
                                                                      )
                                                                    ]),
                                                              ),
                                                              TableCell(
                                                                verticalAlignment:
                                                                    TableCellVerticalAlignment
                                                                        .middle,
                                                                child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Container(
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                2,
                                                                            right:
                                                                                2),
                                                                        // color: Colors.grey[100],
                                                                        child: Align(
                                                                            alignment: Alignment
                                                                                .center,
                                                                            child: Text('Order',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold))),
                                                                      )
                                                                    ]),
                                                              )
                                                            ],
                                                          ),
                                                          // : firstSearch ? Text("Nothing found...") : Text(""),
                                                          // list_of_rows.length > 0 ? Column(
                                                          //   children: list_of_rows,
                                                          // ) : Text(""),

                                                          // for(int i =0; i<list_of_rows.length; i++) list_of_rows[i]
                                                        ])
                                              : firstSearch
                                                  ? Center(
                                                      child:
                                                          Text("No Data Found"))
                                                  : Text("")
                                          : CircularProgressIndicator(),
                                      isTableLoaded
                                          ? list_of_rows.length > 0
                                              ? Table(
                                                  border: TableBorder.all(
                                                      color: Color(0xffa6a4a4),
                                                      style: BorderStyle.solid,
                                                      width: 2),
                                                  children: list_of_rows,
                                                )
                                              : Text("")
                                          : Text("")
                                      //     Table(
                                      //       defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                      // border: TableBorder.all(
                                      // color: Color(0xffa6a4a4),
                                      // style: BorderStyle.solid,
                                      // width: 2),

                                      //       children: [
                                      //     TableRow(

                                      //       decoration: BoxDecoration(color: Color(0xffeceaea)),
                                      //       children: [
                                      //  ]),
                                      //   for(int i = 0; i < 10; i++)  TableRow( children: [
                                      //       Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children:[Text('3M PEARL WHITE GB HWC', style: TextStyle(fontSize: 12.0))]),
                                      //       Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children:[Text('285', style: TextStyle(fontSize: 12.0))]),
                                      //       Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children:[Text('31.50 X 41.50', style: TextStyle(fontSize: 12.0))]),
                                      //       Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children:[Text('200', style: TextStyle(fontSize: 12.0))]),
                                      //       Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children:[Text('1300', style: TextStyle(fontSize: 12.0))]),
                                      //       Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children:[Text('G!', style: TextStyle(fontSize: 12.0))]),
                                      //       Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children:[Container(margin: EdgeInsets.only(right: 5), color: blue , child: Center(child: IconButton(onPressed: (){
                                      //         Navigator.push(context, MaterialPageRoute(builder: ((context) => PlaceNewOrderScreen())));
                                      //       }, color: Colors.white, icon: Icon(Icons.shopping_cart_outlined))))]),
                                      //     ]),

                                      //                       ],
                                      //     )
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Center(child: CircularProgressIndicator())
      ),
    );
  }
}
