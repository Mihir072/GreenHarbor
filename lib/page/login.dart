import 'package:GreenHarbor/core/color.dart';
import 'package:GreenHarbor/page/forgotpassword.dart';
import 'package:GreenHarbor/page/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginIn extends StatefulWidget {
  const LoginIn({Key? key}) : super(key: key);

  @override
  State<LoginIn> createState() => _LoginInState();
}

class _LoginInState extends State<LoginIn> {
  String email = "", password = "";

  final _formkey = GlobalKey<FormState>();

  TextEditingController useremailcontroller = new TextEditingController();
  TextEditingController userpasswordcontroller = new TextEditingController();

  userLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: useremailcontroller.text,
        password: userpasswordcontroller.text,
      );
      // Navigate to Home Page after successful login
      Navigator.pushReplacementNamed(context,
          'BottumNav'); // Assuming 'BottumNav' is the route name for your home page
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'No User Found for that Email',
            style: TextStyle(fontSize: 18.0, color: Colors.black),
          ),
        ));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Wrong Password Provided by User',
            style: TextStyle(fontSize: 18.0, color: Colors.black),
          ),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(),
                child: Image.asset('assets/images/flower.png'),
              ),
              // Image.asset('assets/image/flower.jpg'),
              const Padding(
                padding: EdgeInsets.only(
                  top: 10,
                ),
                child: Text(
                  "Login Verification",
                  textAlign: TextAlign.center,
                  textScaler: TextScaler.linear(1.5),
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  top: 2,
                ),
                child: Text(
                  "We need register your account befor getting\n started!",
                  textAlign: TextAlign.center,
                  //textScaler: TextScaler.linear(1.5),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: txtcolor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
                child: TextFormField(
                  controller: useremailcontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Email';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined),
                    hintText: 'Email',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
                child: TextFormField(
                  controller: userpasswordcontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Password';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline_rounded),
                    hintText: 'Password',
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 40)),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPassword(),
                          ));
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: txtcolor,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                child: GestureDetector(
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      setState(() {
                        email = useremailcontroller.text;
                        password = userpasswordcontroller.text;
                      });
                    }
                    userLogin();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 80.0,
                      vertical: 12.0,
                    ),
                    decoration: BoxDecoration(
                      color: green,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Text(
                      "Login In ",
                      style: TextStyle(
                          color: white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUp(),
                      ));
                },
                child: const Text(
                  "Don't have an account? Sign Up",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: txtcolor,
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
