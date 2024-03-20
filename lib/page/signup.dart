import 'package:GreenHarbor/core/color.dart';
import 'package:GreenHarbor/data/bottumnav.dart';
import 'package:GreenHarbor/page/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String name = "", email = "", password = "";

  TextEditingController namecontroller = new TextEditingController();

  TextEditingController emailcontroller = new TextEditingController();

  TextEditingController passwordcontroller = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  registration() async {
    if (password != null) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        ScaffoldMessenger.of(context).showSnackBar((const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            'Registered Successfully',
            style: TextStyle(fontSize: 20.0),
          ),
        )));
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BottumNav(),
            ));
      } on FirebaseException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar((const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              'Password Provided is too Weak ',
              style: TextStyle(fontSize: 20.0),
            ),
          )));
        } else if (e.code == 'email_already_in_use') {
          ScaffoldMessenger.of(context).showSnackBar((const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              'Account Already exsists ',
              style: TextStyle(fontSize: 20.0),
            ),
          )));
        }
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
                  "SignUp Verification",
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
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: txtcolor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 50, right: 50),
                child: TextFormField(
                  controller: namecontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Name';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline_rounded),
                    hintText: 'Name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 50, right: 50),
                child: TextFormField(
                  controller: emailcontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter E-mail';
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
                padding: const EdgeInsets.only(
                    top: 10, left: 50, right: 50, bottom: 20),
                child: TextFormField(
                  controller: passwordcontroller,
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
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                child: GestureDetector(
                  onTap: () async {
                    if (_formkey.currentState!.validate()) {
                      setState(() {
                        name = namecontroller.text;
                        email = emailcontroller.text;
                        password = passwordcontroller.text;
                      });
                    }
                    registration();
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
                      "Sign Up ",
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
                        builder: (context) => LoginIn(),
                      ));
                },
                child: const Text(
                  "Already have an account? Login In",
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
