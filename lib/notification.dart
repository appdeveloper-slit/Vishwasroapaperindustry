import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vpi/colors.dart';
import 'package:vpi/globalurls.dart';
import 'package:vpi/signup.dart';
// import 'package:validators/sanitizers.dart';
// import 'package:validators/validators.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);
  @override
  State<NotificationsScreen> createState() => NotificationsScreenState();
}

class NotificationsScreenState extends State<NotificationsScreen> {
  List<Widget> all_notifications = [];
  bool load = true;

  Widget notificationCard(String title, String description, String date) {
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
                      title.toString(),
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  Align(
                    child: Text(
                      description.toString(),
                      style: TextStyle(),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  SizedBox(height: 5,),
                  Align(
                    child: Text(
                      date.toString(),
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

  void getNotification() async {
    setState(() {
      load = false;

    });
    SharedPreferences sp = await SharedPreferences.getInstance();
    
    var dio = Dio();
    var formdata = FormData.fromMap(
        {
          'user_id': sp.getString('user_id'), 
          });
    final response = await dio.post(getNotificationUrl(), data: formdata);
    var result = response.data;
    print(result);
    all_notifications = [];

      for(int i = 0; i < result['notifications'].length; i++){
        all_notifications.add(notificationCard(result['notifications'][i]['title'], result['notifications'][i]['description'], result['notifications'][i]['created_at'])); 
      }

    setState(() {
      all_notifications = all_notifications;
      load = true;
    });
  }

  @override
  void initState() {
    getNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Notifications"), centerTitle: true,),
        body: ListView(
          children: [
            Center(
              child: load ? all_notifications.length > 0 ? Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(5),
                  child: Column(
                    children:all_notifications,
                  )): Container(margin: EdgeInsets.only(top: 35), child: Text("No notifications")) : Container(margin: EdgeInsets.only(top: 35), child: CircularProgressIndicator()),
            ),
          ],
        ));
  }
}
