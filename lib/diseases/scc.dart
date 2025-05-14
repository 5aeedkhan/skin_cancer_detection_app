import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/diseases/diseases.dart';
import 'package:flutter_application_1/history/history.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/skin_test/3-display_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SCC extends StatefulWidget {
  const SCC({Key? key}) : super(key: key);

  @override
  State<SCC> createState() => _SCCState();
}

class _SCCState extends State<SCC> {
  var infotxt;
  var diseases_or_test;

  Future<void> _loadData() async {
    final _loadedData =
        await rootBundle.loadString('assets/10.txt'); // Your SCC info file
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
    print('get Pref of SCC page has been done');
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
        leading: IconButton(
          onPressed: () {
            if (diseases_or_test == 'diseases') {
              Navigator.of(context).pop();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Diseases()));
            } else if (diseases_or_test == 'history') {
              Navigator.of(context).pop();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => History()));
            } else {
              Navigator.of(context).pop();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Display_image()));
            }
          },
          icon: Icon(Icons.arrow_back_outlined),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()));
            },
            icon: Icon(Icons.home_sharp),
          ),
        ],
        flexibleSpace: Expanded(
          child: Container(
            padding: EdgeInsets.only(top: 35),
            child: Text('Squamous Cell Carcinoma',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
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
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
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
                child: Image.asset(
                  'assets/SquamousCellCarcinoma.jpg', // Your SCC image
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              child: Card(
                color: Colors.white,
                child: Container(
                  child: Text('$infotxt',
                      style: TextStyle(fontSize: 18, color: Colors.black)),
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
