import 'package:GreenHarbor/admin/admin_home.dart';
import 'package:GreenHarbor/core/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  TextEditingController usernamecontroller = new TextEditingController();
  TextEditingController userpasswordcontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 80, top: 60),
              child: Text(
                "Let's Login with Admin",
                style: TextStyle(fontFamily: 'Poppins', fontSize: 25),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 350,
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: circle,
                    borderRadius: BorderRadius.vertical(
                        top: Radius.elliptical(
                            MediaQuery.of(context).size.width, 100.0))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 180, right: 30, left: 30),
              child: Form(
                key: _formkey,
                child: Card(
                  elevation: 15.0,
                  child: Container(
                    height: 400,
                    width: 400,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 50, right: 20, left: 20),
                          child: TextFormField(
                            controller: usernamecontroller,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Username';
                              }
                              // return null;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              prefixIcon: Icon(Icons.person),
                              hintText: 'Username',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 25, right: 20, left: 20, bottom: 30),
                          child: TextFormField(
                            controller: userpasswordcontroller,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Password';
                              }
                              //return null;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              prefixIcon: Icon(Icons.password),
                              hintText: 'Password',
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // LoginAdmin();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdminHome()));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 80.0,
                              vertical: 12.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black,
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
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  LoginAdmin() {
    FirebaseFirestore.instance.collection('Admin').get().then((snapshot) {
      snapshot.docs.forEach((result) {
        if (result.data()['id'] == usernamecontroller.text.trim() &&
            result.data()['password'] == userpasswordcontroller.text.trim()) {
          Route route = MaterialPageRoute(builder: (context) => AdminHome());
          // Navigator.pushReplacement(context, route);
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => AdminHome()));
        }
        // if (result.data()['id'] != usernamecontroller.text.trim()) {
        //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //     content: Text(
        //       'The Username is not Correct!',
        //       style: TextStyle(fontSize: 18.0, color: Colors.white),
        //     ),
        //   ));
        // } else if (result.data()['password'] !=
        //     userpasswordcontroller.text.trim()) {
        //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //     content: Text(
        //       'The password is not Correct!',
        //       style: TextStyle(fontSize: 18.0, color: Colors.white),
        //     ),
        //   ));
        // }
        // if (result.data()['id'] == usernamecontroller.text.trim() &&
        //     result.data()['password'] == userpasswordcontroller.text.trim()) {
        //   Route route = MaterialPageRoute(builder: (context) => AdminHome());
        //   Navigator.pushReplacement(context, route);
        //   Navigator.push(
        //       context, MaterialPageRoute(builder: (context) => AdminHome()));
        // }
      });
    });
  }
}
