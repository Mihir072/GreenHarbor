import 'package:GreenHarbor/data/bottumnav.dart';
import 'package:GreenHarbor/page/home.dart';
import 'package:GreenHarbor/data/otp.dart';
import 'package:GreenHarbor/data/phone.dart';
import 'package:GreenHarbor/page/login.dart';
import 'package:GreenHarbor/page/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'page/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Gilroy',
      ),
      initialRoute: 'LoginIn', // Set initial route
      routes: {
        'LoginIn': (context) => LoginIn(), // Define login page route
        'BottumNav': (context) => BottumNav(), // Define home page route
      },
    );
  }
}
