import 'package:GreenHarbor/admin/admin_home.dart';
import 'package:GreenHarbor/data/bottumnav.dart';
import 'package:GreenHarbor/page/login.dart';
import 'package:GreenHarbor/widgets/app_constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = publishableKey;
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
      // home: AdminHome(),
      initialRoute: 'LoginIn', // Set initial route
      routes: {
        'LoginIn': (context) => const LoginIn(),
        'BottumNav': (context) => const BottumNav(),
      },
    );
  }
}
