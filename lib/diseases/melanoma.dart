import 'package:flutter_application_1/diseases/diseases.dart';
import 'package:flutter_application_1/history/history.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/skin_test/3-display_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Melanoma extends StatefulWidget {
  const Melanoma({Key? key}) : super(key: key);

  @override
  State<Melanoma> createState() => _MelanomaState();
}

class _MelanomaState extends State<Melanoma> {
  bool agree = false;
  var infotxt;
  var diseases_or_test;

  Future<void> _loadData() async {
    final _loadedData = await rootBundle.loadString('assets/4.txt');
    setState(() {
      infotxt = _loadedData;
    });
  }

  getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      diseases_or_test = prefs.getString('diseases_or_test');
    });

    print('-----------------------');
    print(diseases_or_test);
    print('-----------------------');

    print('get Pref of page3 has been done');
  }

  @override
  void initState() {
    _loadData();
    getPref();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('augustus'),
        leading: IconButton(
            onPressed: () {
              if (diseases_or_test == 'test') {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Display_image()),
                );
              } else if (diseases_or_test == 'history') {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => History()),
                );
              } else {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Diseases()),
                );
              }
            },
            icon: Icon(Icons.arrow_back_outlined)),

        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
              icon: Icon(Icons.home_sharp)),
        ],
        flexibleSpace: Container(
          padding: EdgeInsets.only(top: 35),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Color.fromARGB(255, 16, 170, 226),
                Color.fromARGB(255, 87, 179, 212),
              ],
            ),
          ),
          child: Text(
            'Melanoma',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            //  colors: [Color.fromARGB(255, 255, 255, 255), Color.fromARGB(255, 174, 217, 255)],
            //  colors: [Color.fromARGB(255, 96, 165, 239), Color.fromARGB(255, 153, 204, 250)], // mahmoud
            colors: [
              Color.fromARGB(146, 147, 226, 255),
              Color.fromARGB(255, 227, 245, 255)
            ],

            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: ListView(
          children: [
            SizedBox(height: 10),
            Container(
                height: 300,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                child: Card(
                    color: Colors.white,
                    // shape: Border.all(color: Colors.black),
                    child: Image.asset(
                      'assets/Melanoma.jpg',
                      fit: BoxFit.fill,
                    ))),
            Container(
              child: Card(
                color: Colors.white,
                // shape: Border.all(color: Colors.black),
                child: Container(
                  child: Text(
                    '$infotxt',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  // margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
