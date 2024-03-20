import 'package:GreenHarbor/core/color.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formkey = GlobalKey<FormState>();

  TextEditingController emailcontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
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
                    padding: EdgeInsets.only(
                        top: 40, right: 30, left: 30, bottom: 100),
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
                          hintStyle: TextStyle(color: Colors.white),
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: white,
                          )),
                    )),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      // if (_formkey.currentState!.validate()) {
                      //   setState(() {
                      //     email = useremailcontroller.text;
                      //     password = userpasswordcontroller.text;
                      //   });
                      // }
                      // userLogin();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 80.0,
                        vertical: 12.0,
                      ),
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const Text(
                        "Login In ",
                        style: TextStyle(
                            color: black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins'),
                      ),
                    ),
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
