import 'package:GreenHarbor/service/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:GreenHarbor/core/color.dart';
import 'package:GreenHarbor/data/category_model.dart';
import 'package:GreenHarbor/data/plant_data.dart';
import 'package:GreenHarbor/data/plant_model.dart';
import 'package:GreenHarbor/page/cart_page.dart';
import 'package:GreenHarbor/page/details.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController controller = PageController();
  List<Plants> cartItems = []; // Declare cartItems here

  Stream? fooditemStream;

  ontheload() async {
    fooditemStream = await DatabaseMothed().getFoodItem("Pizza");
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    controller = PageController(viewportFraction: 0.6, initialPage: 0);
    super.initState();
  }

  Widget allItems() {
    return StreamBuilder(
        stream: fooditemStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: snapshot.data.doc.lenght,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                  })
              : CircularProgressIndicator();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello, Mihir",
                              style: TextStyle(
                                  fontFamily: "Poppins", fontSize: 17),
                            ),
                            Text(
                              "Welcome to our Green Harbor",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 12,
                                  color: txtcolor),
                            ),
                          ],
                        ),
                        Material(
                          elevation: 8,
                          borderRadius: BorderRadius.circular(
                              10), // Apply borderRadius here
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CartPage(myPlants: myPlants)),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              width: 40,
                              height: 40,
                              child: Image.asset(
                                  'assets/images/shopping-cart.gif'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 45.0,
                          width: 320.0,
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                            color: white,
                            border: Border.all(color: green),
                            boxShadow: [
                              BoxShadow(
                                color: green.withOpacity(0.15),
                                blurRadius: 10,
                                offset: const Offset(0, 0),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(
                                height: 45,
                                width: 270,
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Search',
                                  ),
                                ),
                              ),
                              Image.asset(
                                'assets/images/search.gif',
                                height: 28,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 35.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    for (int i = 0; i < categories.length; i++)
                      GestureDetector(
                        onTap: () {
                          setState(() => selectId = categories[i].id);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              categories[i].name,
                              style: TextStyle(
                                color: selectId == i
                                    ? green
                                    : black.withOpacity(0.7),
                                fontSize: 16.0,
                              ),
                            ),
                            if (selectId == i)
                              const CircleAvatar(
                                radius: 3,
                                backgroundColor: green,
                              )
                          ],
                        ),
                      )
                  ],
                ),
              ),
              SizedBox(
                height: 320.0,
                child: PageView.builder(
                  itemCount: myPlants.length,
                  controller: controller,
                  physics: const BouncingScrollPhysics(),
                  padEnds: false,
                  pageSnapping: true,
                  onPageChanged: (value) => setState(() => activePage = value),
                  itemBuilder: (itemBuilder, index) {
                    bool active = index == activePage;
                    return slider(active, index);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Popular',
                      style: TextStyle(
                        color: black.withOpacity(0.7),
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    Image.asset(
                      'assets/icons/more.png',
                      color: green,
                      height: 20,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 130.0,
                child: ListView.builder(
                  itemCount: populerPlants.length,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(left: 20.0),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (itemBuilder, index) {
                    return Container(
                      width: 200.0,
                      margin: const EdgeInsets.only(right: 20, bottom: 10),
                      decoration: BoxDecoration(
                        color: lightGreen,
                        boxShadow: [
                          BoxShadow(
                            color: green.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                populerPlants[index].imagePath,
                                width: 70,
                                height: 70,
                              ),
                              const SizedBox(width: 10.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    populerPlants[index].name,
                                    style: TextStyle(
                                      color: black.withOpacity(0.7),
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Text(
                                    '\u20B9${populerPlants[index].price.toStringAsFixed(0)}',
                                    style: TextStyle(
                                      color: black.withOpacity(0.4),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Positioned(
                            right: 20,
                            bottom: 20,
                            child: CircleAvatar(
                              backgroundColor: green,
                              radius: 15,
                              child: GestureDetector(
                                onTap: () {
                                  // Add the current plant to the cart
                                  setState(() {
                                    cartItems.add(myPlants[index]);
                                  });
                                  // Navigate to the cart page
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CartPage(myPlants: cartItems),
                                    ),
                                  );
                                },
                                child: Image.asset(
                                  'assets/icons/add.png',
                                  color: white,
                                  height: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  AnimatedContainer slider(active, index) {
    double margin = active ? 20 : 30;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
      margin: EdgeInsets.all(margin),
      child: mainPlantsCard(index),
    );
  }

  Widget mainPlantsCard(index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (builder) => DetailsPage(plant: myPlants[index]),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: white,
          boxShadow: [
            BoxShadow(
              color: black.withOpacity(0.05),
              blurRadius: 15,
              offset: const Offset(5, 5),
            ),
          ],
          border: Border.all(color: green, width: 2),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: lightGreen,
                boxShadow: [
                  BoxShadow(
                    color: black.withOpacity(0.05),
                    blurRadius: 15,
                    offset: const Offset(5, 5),
                  ),
                ],
                borderRadius: BorderRadius.circular(25.0),
                image: DecorationImage(
                  image: AssetImage(myPlants[index].imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              right: 8,
              top: 8,
              child: CircleAvatar(
                backgroundColor: green,
                radius: 15,
                child: GestureDetector(
                  onTap: () {
                    // Add the current plant to the cart
                    setState(() {
                      cartItems.add(myPlants[index]);
                    });
                    // Navigate to the cart page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartPage(myPlants: cartItems),
                      ),
                    );
                  },
                  child: Image.asset(
                    'assets/icons/add.png',
                    color: white,
                    height: 15,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  '${myPlants[index].name} - \u20B9${myPlants[index].price.toStringAsFixed(0)}',
                  style: TextStyle(
                    color: black.withOpacity(0.7),
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  int selectId = 0;
  int activePage = 0;
}
