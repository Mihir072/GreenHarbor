import 'dart:convert';
import 'package:GreenHarbor/core/color.dart';
import 'package:GreenHarbor/service/shared_pref.dart';
import 'package:GreenHarbor/widgets/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  String? wallet;
  int? add;
  getthesharedpref() async {
    wallet = await SharedPreferanceHelper().getUserWallet();
    setState(() {});
  }

  onthload() async {
    await getthesharedpref();
    setState(() {});
  }

  @override
  void initState() {
    onthload();
    super.initState();
  }

  Map<String, dynamic>? paymentIntent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: Material(
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        padding: const EdgeInsets.only(
                          bottom: 10.0,
                        ),
                        child: const Text('Wallet',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 20,
                                fontWeight: FontWeight.bold))),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 60,
            decoration: const BoxDecoration(color: Color(0xFFF2F2F2)),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Image.asset(
                    "assets/images/wallet.gif",
                    height: 50,
                    width: 50,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        "Your Wallet",
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                      ),
                    ),
                    Text(
                      '\u20B9 100',
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Padding(
            padding: EdgeInsets.only(right: 230),
            child: Text(
              'Add Money',
              style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: const EdgeInsets.only(
                    right: 10, left: 10, top: 5, bottom: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: txtcolor),
                    borderRadius: BorderRadius.circular(20)),
                child: const Padding(
                  padding: EdgeInsets.only(right: 5, left: 5),
                  child: Text(
                    '\u20B9 100',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 18),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                    right: 10, left: 10, top: 5, bottom: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: txtcolor),
                    borderRadius: BorderRadius.circular(20)),
                child: const Padding(
                  padding: EdgeInsets.only(right: 5, left: 5),
                  child: Text(
                    '\u20B9 300',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 18),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                    right: 10, left: 10, top: 5, bottom: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: txtcolor),
                    borderRadius: BorderRadius.circular(20)),
                child: const Padding(
                  padding: EdgeInsets.only(right: 5, left: 5),
                  child: Text(
                    '\u20B9 500',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 18),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                    right: 10, left: 10, top: 5, bottom: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: txtcolor),
                    borderRadius: BorderRadius.circular(20)),
                child: const Padding(
                  padding: EdgeInsets.only(right: 5, left: 5),
                  child: Text(
                    '\u20B9 1000',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () {
              makePayment("100");
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 120.0,
                vertical: 12.0,
              ),
              decoration: BoxDecoration(
                color: green,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Text(
                "Add Money ",
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
    ));
  }

  Future<void> makePayment(String amount) async {
    try {
      paymentIntent = await createPaymentIntent(amount, 'INR');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent!['client_secret'],
                  style: ThemeMode.dark,
                  merchantDisplayName: 'Adnan'))
          .then((value) {});

      displayPaymentSheet(context, amount);
    } catch (e, s) {
      print('exception: $e$s');
    }
  }

  displayPaymentSheet(BuildContext context, String amount) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        add = int.parse(wallet!) + int.parse(amount);
        await SharedPreferanceHelper().saveUserWallet(add.toString());

        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (_) => AlertDialog(
            content: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                    Text('Payment Successful')
                  ],
                )
              ],
            ),
          ),
        );
        await getthesharedpref();
        paymentIntent = null;
      }).onError((error, stackTrace) {
        if (error is StripeException) {
          if (error.error.localizedMessage ==
              'The payment flow has been canceled') {
            // Handle payment cancellation
            showDialog(
              context: context,
              builder: (_) => const AlertDialog(
                content: Text('The payment flow has been canceled'),
              ),
            );
          } else {
            // Handle other Stripe exceptions
            print('Stripe Exception: ${error.error.localizedMessage}');
          }
        } else {
          // Handle other types of exceptions
          print('Error occurred: $error');
        }
      });
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      print('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount) * 100);

    return calculatedAmount.toString();
  }
}
