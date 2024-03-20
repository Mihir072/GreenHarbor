import 'package:flutter/material.dart';
import 'package:GreenHarbor/core/color.dart';
import 'package:GreenHarbor/data/plant_model.dart';
import 'package:velocity_x/velocity_x.dart';

class DetailsPage extends StatefulWidget {
  final Plants plant;
  DetailsPage({Key? key, required this.plant}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  get floatingActionButton => null;

  int a = 1;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                    elevation: 2,
                    color: barcolor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60),
                    ),
                    child: Container(
                      height: height / 2,
                      decoration: BoxDecoration(
                        color: barcolor,
                        boxShadow: [
                          BoxShadow(
                            color: grey.withOpacity(0.2),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(60),
                          bottomRight: Radius.circular(60),
                        ),
                        image: DecorationImage(
                          image: AssetImage(widget.plant.imagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: widget.plant.name,
                                    style: TextStyle(
                                        color: black.withOpacity(0.8),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                        fontFamily: 'Poppins'),
                                  ),
                                  TextSpan(
                                    text: '  (${widget.plant.category} Plant)',
                                    style: TextStyle(
                                        color: black.withOpacity(0.5),
                                        fontSize: 12.0,
                                        fontFamily: 'Poppins'),
                                  ),
                                ],
                              ),
                            ),
                            Material(
                              elevation: 3,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                height: 30.0,
                                width: 30.0,
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: barcolor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: barcolor.withOpacity(0.2),
                                      blurRadius: 15,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Image.asset(
                                  'assets/icons/heart.png',
                                  color: white,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        RichText(
                          text: TextSpan(
                            text: widget.plant.description,
                            style: TextStyle(
                                color: black.withOpacity(0.5),
                                fontSize: 15.0,
                                height: 1.4,
                                letterSpacing: 0.5,
                                fontFamily: 'Poppins'),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Row(children: [
                          Material(
                            elevation: 3,
                            borderRadius: BorderRadius.circular(10),
                            child: GestureDetector(
                              onTap: () {
                                if (a > 1) {
                                  --a;
                                }
                                setState(() {});
                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: barcolor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Icon(
                                  Icons.remove,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15, left: 15),
                            child: Text(
                              a.toString(),
                              style: const TextStyle(
                                //color: black.withOpacity(0.9),
                                fontFamily: 'Poppins',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Material(
                            elevation: 3,
                            borderRadius: BorderRadius.circular(10),
                            child: GestureDetector(
                              onTap: () {
                                ++a;
                                setState(() {});
                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: barcolor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 685),
                child: GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            "Buying not supportedd yet..\nWe will develop in future"
                                .text
                                .bold
                                .center
                                .make()));
                  },
                  child: Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 100.0,
                          vertical: 12.0,
                        ),
                        decoration: BoxDecoration(
                          color: barcolor,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Text(
                          'Buy \u20B9${widget.plant.price.toStringAsFixed(0)}',
                          style: const TextStyle(
                            color: black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
