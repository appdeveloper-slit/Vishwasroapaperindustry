import 'package:flutter/material.dart';

class PaperDescription extends StatefulWidget {
  const PaperDescription({super.key});

  @override
  State<PaperDescription> createState() => _PaperDescriptionState();
}

class _PaperDescriptionState extends State<PaperDescription> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text('Suppliers of Duplex Board Mills',style: TextStyle(color: Colors.black)),
          centerTitle: true,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back, color: Colors.blue.shade900)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/logo1.png',
                      height: 50.0,
                      width: 100.0,
                    ),
                    SizedBox(
                      width: 12.0,
                    ),
                    Expanded(
                        child: Text('Balkrishna Paper Mills Ltd. (Kalyan)')),
                    SizedBox(
                      height: 30.0,
                    ),
                  ],
                ),
                SizedBox(
                      height: 35.0,
                    ),
                Row(
                  children: [
                    Image.asset(
                      'assets/logo2.png',
                      height: 50.0,
                      width: 100.0,
                    ),
                    SizedBox(
                      width: 12.0,
                    ),
                    Expanded(
                        child: Text(
                            'Three-M Paper Manufacture Co. Pvt. Ltd.')),
                    SizedBox(
                      height: 30.0,
                    ),
                  ],
                ),
                SizedBox(
                      height: 35.0,
                    ),
                Row(
                  children: [
                    Image.asset(
                      'assets/logo3.png',
                      height: 50.0,
                      width: 100.0,
                    ),
                    SizedBox(
                      width: 12.0,
                    ),
                    Expanded(child: Text('Tirthak Paper Mill Pvt. Ltd.')),
                    SizedBox(
                      height:30.0,
                    ),
                  ],
                ),
                SizedBox(
                      height: 35.0,
                    ),
                Row(
                  children: [
                    Image.asset(
                      'assets/logo4.png',
                      height: 50.0,
                      width: 100.0,
                    ),
                    SizedBox(
                      width: 12.0,
                    ),
                    Expanded(
                        child: Text('Sabarmati Papers Private Limited')),
                    SizedBox(
                      height: 30.0,
                    ),
                  ],
                ),
                SizedBox(
                      height: 35.0,
                    ),
                Row(
                  children: [
                    Image.asset(
                      'assets/logo5.png',
                      height: 50.0,
                      width: 100.0,
                    ),
                    SizedBox(
                      width: 12.0,
                    ),
                    Text('Camerich Paper Mill (Morbi)'),
                    SizedBox(
                      height: 30.0,
                    ),
                  ],
                ),
                SizedBox(
                      height: 35.0,
                    ),
                Row(
                  children: [
                    Image.asset(
                      'assets/logo6.png',
                      height: 50.0,
                      width: 100.0,
                    ),
                    SizedBox(
                      width: 12.0,
                    ),
                    Text('Diyan Papers LLP'),
                    SizedBox(
                      height: 30.0,
                    ),
                  ],
                ),
                SizedBox(
                      height: 35.0,
                    ),
                Row(
                  children: [
                    Image.asset(
                      'assets/logo7.png',
                      height: 50.0,
                      width: 100.0,
                    ),
                    SizedBox(
                      width: 12.0,
                    ),
                    Text('Milano Paper Mill Pvt. Ltd.'),
                    SizedBox(
                      height: 35.0,
                    ),
                  ],
                ),
                SizedBox(
                      height: 35.0,
                    ),
                Row(
                  children: [
                    Image.asset(
                      'assets/logo8.png',
                      height: 50.0,
                      width: 100.0,
                    ),
                    SizedBox(
                      width: 12.0,
                    ),
                    Text('Sudarshan Paper & Product'),
                    SizedBox(
                      height: 30.0,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
