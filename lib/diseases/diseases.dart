import 'package:flutter_application_1/diseases/Vascular%20Lesion.dart';
import 'package:flutter_application_1/diseases/actinic_keratosis.dart';
import 'package:flutter_application_1/diseases/basel.dart';
import 'package:flutter_application_1/diseases/benign_keratosis.dart';
import 'package:flutter_application_1/diseases/cancer.dart';
import 'package:flutter_application_1/diseases/dermatofibroma.dart';
import 'package:flutter_application_1/diseases/diseases.dart';
import 'package:flutter_application_1/diseases/melanocytic_nevus.dart';
import 'package:flutter_application_1/diseases/melanoma.dart';
import 'package:flutter_application_1/history/history.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/skin_test/3-display_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Diseases extends StatefulWidget {
  const Diseases({Key? key}) : super(key: key);

  @override
  State<Diseases> createState() => _DiseasesState();
}

class _DiseasesState extends State<Diseases> {
  @override
  bool agree = false;
  var diseases_or_test = 'diseases';

  savePref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('diseases_or_test', diseases_or_test);
    });

    print('save prefs page3 done successfllly');
    print(diseases_or_test);
  }

  @override
  void initState() {
    savePref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('augustus'),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
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
        flexibleSpace: Expanded(
          child: Container(
            padding: EdgeInsets.only(top: 35),
            child: Text(
              'Diseases',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Color.fromARGB(255, 16, 170, 226),
                    Color.fromARGB(255, 87, 179, 212),
                  ]),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                  child: Card(
                    color: Colors.white,
                    shape: Border.all(color: Colors.black),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Cancer()),
                        );
                      },
                      splashColor: Colors.amber,
                      child: Ink(
                        child: ListTile(
                          minLeadingWidth: 0,
                          horizontalTitleGap: 16.0,
                          leading: Icon(Icons.info,
                              color: Color.fromARGB(255, 1, 70, 126)),
                          title: Text(
                            'What is skin cancer',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 25,
                                color: Color.fromARGB(255, 1, 70, 126)),
                          ),
                          subtitle: Text(
                            'info with details about skin cancer',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 1, 70, 126)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Container(
                //   padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                //   child: Card(
                //     color: Colors.white,
                //     shape: Border.all(color: Colors.black),
                //     child: InkWell(
                //       onTap: () {
                //         Navigator.of(context).pop();
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => Benign_keratosis()),
                //         );
                //       },
                //       splashColor: Colors.amber,
                //       child: Ink(
                //         child: ListTile(
                //           minLeadingWidth: 0,
                //           horizontalTitleGap: 16.0,
                //           leading: Icon(Icons.info,
                //               color: Color.fromARGB(255, 1, 70, 126)),
                //           title: Text(
                //             'Benign Keratosis',
                //             textAlign: TextAlign.left,
                //             style: TextStyle(
                //                 fontSize: 25,
                //                 color: Color.fromARGB(255, 1, 70, 126)),
                //           ),
                //           subtitle: Text(
                //             'Benign skin lesion',
                //             overflow: TextOverflow.ellipsis,
                //             maxLines: 1,
                //             textAlign: TextAlign.left,
                //             style: TextStyle(
                //                 fontSize: 14,
                //                 color: Color.fromARGB(255, 1, 70, 126)),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),

                // Keep the commented code as it is
                // Container(
                //   padding:EdgeInsets.symmetric(vertical : 2,horizontal: 5),
                //   child: Card(
                //     color: Colors.white,
                //     shape: Border.all(color: Colors.black),
                //     child: InkWell(
                //       onTap: ()  {
                //         Navigator.of(context).pop();
                //         Navigator.push(context,MaterialPageRoute(builder: (context) => Vascular_lesion()),);
                //       }, // should add diseases page
                //         splashColor: Colors.amber,
                //         child: Ink(
                //           child: ListTile(
                //             minLeadingWidth : 0,
                //             horizontalTitleGap: 16.0,
                //             leading: Icon(Icons.info,color: Color.fromARGB(255, 1, 70, 126) ),
                //             title: Text(
                //               'Vascular Lesion',
                //               textAlign: TextAlign.left,
                //               style: TextStyle(fontSize: 25, color: Color.fromARGB(255, 1, 70, 126)  ),
                //             ),
                //             subtitle: Text(
                //             'Benign skin lession',
                //             overflow: TextOverflow.ellipsis,
                //             maxLines: 1,
                //               textAlign: TextAlign.left,
                //                 style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 1, 70, 126) ),
                //             ),),),),),
                // ),

                Container(
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                  child: Card(
                    color: Colors.white,
                    shape: Border.all(color: Colors.black),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Melanoma()),
                        );
                      },
                      splashColor: Colors.amber,
                      child: Ink(
                        child: ListTile(
                          minLeadingWidth: 0,
                          horizontalTitleGap: 16.0,
                          leading: Icon(Icons.info,
                              color: Color.fromARGB(255, 1, 70, 126)),
                          title: Text(
                            'Melanoma',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 25,
                                color: Color.fromARGB(255, 1, 70, 126)),
                          ),
                          subtitle: Text(
                            'Malignant skin lesion',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 1, 70, 126)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                  child: Card(
                    color: Colors.white,
                    shape: Border.all(color: Colors.black),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Basel()),
                        );
                      },
                      splashColor: Colors.amber,
                      child: Ink(
                        child: ListTile(
                          minLeadingWidth: 0,
                          horizontalTitleGap: 16.0,
                          leading: Icon(Icons.info,
                              color: Color.fromARGB(255, 1, 70, 126)),
                          title: Text(
                            'Basal Cell Carcinoma',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 25,
                                color: Color.fromARGB(255, 1, 70, 126)),
                          ),
                          subtitle: Text(
                            'Malignant skin lesion',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 1, 70, 126)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
