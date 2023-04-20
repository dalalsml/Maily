import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'animated_bottom_navbar.dart';
import 'list_mail.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) => Scaffold(

      // ignore: avoid_unnecessary_containers
      bottomNavigationBar: BottomAppBar(child: AnimatedBottomNavBar(0)),
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
            Expanded(child: SingleChildScrollView(child: Listmails())),
            //bottomNavigationBar:BottomAppBar(child: AnimatedBottomNavBar(),),
          ],
        ),
      )
      //
      );
}
