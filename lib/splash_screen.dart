import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/modules/login_screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

class Splash2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SplashScreen(
        gradientBackground: LinearGradient(
          colors: [
            Color.fromARGB(146, 147, 226, 255),
            Color.fromARGB(255, 227, 245, 255)
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        seconds: 4,
        navigateAfterSeconds: const SecondScreen(),
        image: Image.asset('assets/logo2.png', fit: BoxFit.fill),
        photoSize: 200.0,
        loadingText: Text(
          "We care about your health",
          style: TextStyle(color: Colors.white),
        ),
        loaderColor: Color.fromARGB(255, 227, 245, 255),
      ),
    );
  }
}

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  var user;
  getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      user = prefs.getString('email');
    });

    print('--------------------');
    print(user);
  }

  Future<void> parameter_() async {
    try {
      {
        await Future.delayed(const Duration(milliseconds: 50), () {
          getPref();
        });
      }
    } catch (e) {
      print('parameter_ has failed' + e.toString());
    }
  }

  @override
  void initState() {
    parameter_();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return user == null ? LoginScreen() : Home();
    return LoginScreen();
  }
}
