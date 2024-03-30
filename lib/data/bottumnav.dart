import 'package:GreenHarbor/admin/admin_login.dart';
import 'package:GreenHarbor/core/color.dart';
import 'package:GreenHarbor/page/home.dart';
import 'package:GreenHarbor/page/order.dart';
import 'package:GreenHarbor/page/profile.dart';
import 'package:GreenHarbor/page/wallet.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottumNav extends StatefulWidget {
  const BottumNav({Key? key}) : super(key: key);

  @override
  State<BottumNav> createState() => _BottumNavState();
}

class _BottumNavState extends State<BottumNav> {
  int currentTabIndex = 0;

  late List<Widget> pages;
  late Widget currentpage;
  late HomePage home;
  late Order order;
  late Wallet wallet;
  late AdminLogin admin_login;

  @override
  void initState() {
    home = const HomePage();
    order = const Order();
    wallet = const Wallet();
    admin_login = const AdminLogin();
    pages = [home, order, wallet, admin_login];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          height: 50,
          backgroundColor: Colors.white,
          color: barcolor,
          animationDuration: const Duration(milliseconds: 600),
          onTap: (int index) {
            setState(() {
              currentTabIndex = index;
            });
          },
          items: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: const Image(
                image: AssetImage('assets/images/house.gif'),
                width: 30,
                height: 30,
                fit: BoxFit.cover,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: const Image(
                image: AssetImage('assets/images/bag.gif'),
                width: 30,
                height: 30,
                fit: BoxFit.cover,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: const Image(
                image: AssetImage('assets/images/wallet.gif'),
                width: 30,
                height: 30,
                fit: BoxFit.cover,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: const Image(
                image: AssetImage('assets/images/profile.gif'),
                width: 30,
                height: 30,
                fit: BoxFit.cover,
              ),
            ),
          ]),
      body: pages[currentTabIndex],
    );
  }
}
