import 'package:GreenHarbor/core/color.dart';
import 'package:GreenHarbor/page/login.dart';
import 'package:GreenHarbor/page/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formkey = GlobalKey<FormState>();

  TextEditingController emailcontroller = TextEditingController();
  String email = "";

  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
        "Password Reset Email has been sent ! ",
        style: TextStyle(fontSize: 15.0, fontFamily: 'Poppins'),
      )));
    } on FirebaseAuthException catch (e) {
      if (e.code == "user_not_found") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
          "No user found for that email.",
          style: TextStyle(fontSize: 18.0),
        )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 150),
                  child: Text(
                    "Recover Password",
                    textAlign: TextAlign.center,
                    textScaler: TextScaler.linear(1.5),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 15),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "Enter your email",
                    textAlign: TextAlign.center,
                    textScaler: TextScaler.linear(1.5),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 10),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                      top: 40,
                      right: 30,
                      left: 30,
                    ),
                    child: TextFormField(
                      controller: emailcontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          hintText: 'Email',
                          hintStyle: const TextStyle(color: Colors.white),
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: white,
                          )),
                      style: const TextStyle(color: Colors.white),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 20),
                  child: GestureDetector(
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        setState(() {
                          email = emailcontroller.text;
                        });
                        resetPassword();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 100.0,
                        vertical: 12.0,
                      ),
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const Text(
                        "Send Email ",
                        style: TextStyle(
                            color: black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins'),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUp()));
                      },
                      child: const Text(
                        " Create",
                        style: TextStyle(
                            color: Colors.yellow, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 250, right: 200),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginIn()));
                        },
                        child: const Text(
                          " back to Login",
                          style: TextStyle(
                              color: Colors.yellow,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
