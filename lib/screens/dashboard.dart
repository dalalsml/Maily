import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maily/screens/home_stat.dart';
import 'package:maily/screens/profile.dart';

import 'home.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  Widget getBody(int index) {
    switch (index) {
      case 0:
        {
          return Home();
        }

      case 2:
        {
          return Profile();
        }
      default:
        {
          return homeStat(slect11: 0);
        }
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(

      // ignore: avoid_unnecessary_containers
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color(0xffE9E9E9),
        color: Color(0xff0D202E),
        animationDuration: Duration(milliseconds: 300),
        items: [
          Icon(
            Icons.mail,
            size: 35,
            color: _selectedIndex == 0 ? Color(0xffE26127) : Color(0xffE9E9E9),
          ),
          Icon(
            Icons.bar_chart,
            size: 35,
            color: _selectedIndex == 1 ? Color(0xffE26127) : Color(0xffE9E9E9),
          ),
          Icon(
            Icons.person,
            size: 35,
            color: _selectedIndex == 2 ? Color(0xffE26127) : Color(0xffE9E9E9),
          )
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            if (_selectedIndex == 2) {
              setState(() {
                _selectedIndex = 2;
              });
            } else if (_selectedIndex == 0) {
              setState(() {
                _selectedIndex = 0;
              });
            } else {
              setState(() {
                _selectedIndex = 1;
              });
            }
          });
        },
        index: _selectedIndex, // Set the initial selected index here
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFFBFDDCC),
        toolbarHeight: 120,
        leading: Container(child: Image.asset("assets/logo.png")),
        leadingWidth: 100,
        title: Container(
          child: Image.asset("assets/MAILY_text.png"),
        ),
        centerTitle: true,
        actions: [
          Container(width: 70, child: Image.asset("assets/notificon.png")),
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            Container(
              color: Color(0xFFE9E9E9),
              width: double.maxFinite,
              height: double.maxFinite,
            ),
            SingleChildScrollView(
             
              child: getBody(_selectedIndex)),
            //bottomNavigationBar:BottomAppBar(child: AnimatedBottomNavBar(),),
          ],
        ),
      )
      //
      );
}
