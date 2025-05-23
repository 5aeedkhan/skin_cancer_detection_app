import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/bloc_observer/bloc_observer.dart';
import 'package:flutter_application_1/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dermatology Assistant',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: Splash2(),
    );
  }
}
