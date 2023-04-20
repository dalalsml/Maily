import 'dart:ffi';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maily/screens/animated_bottom_navbar.dart';
import 'package:maily/screens/login.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        color: Color.fromARGB(255, 233, 233, 233),
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                margin: EdgeInsets.only(top: 20),
                child: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 233, 233, 233),
                    child: Image.asset(
                      "assets/achraf.png",
                      fit: BoxFit.cover,
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Image.asset("assets/Telicon.png"),
                      title: Text("+213 674 067 406"),
                      trailing: Image.asset("assets/modifyicon.png"),
                    ),
                    Container(
                      width: 200,
                      child: Divider(
                        thickness: 0.7,
                        color: Colors.black,
                      ),
                    ),
                    ListTile(
                      leading: Image.asset("assets/mailicon.png"),
                      title: Text("lm_boudiaf@esi.dz"),
                      trailing: Image.asset("assets/modifyicon.png"),
                    ),
                    Container(
                      width: 200,
                      child: Divider(
                        thickness: 0.7,
                        color: Colors.black,
                      ),
                    ),
                    ListTile(
                      leading: Image.asset("assets/photoicon.png"),
                      title: Text("Edit picture"),
                      trailing: Image.asset("assets/modifyicon.png"),
                    ),
                    Container(
                      width: 200,
                      child: Divider(
                        thickness: 0.7,
                        color: Colors.black,
                      ),
                    ),
                    ListTile(
                      leading: Image.asset("assets/@icon.png"),
                      title: Text("Set username"),
                      trailing: Image.asset("assets/modifyicon.png"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Image.asset("assets/savedicon.png"),
                      title: Text("Saved Mails"),
                    ),
                    Container(
                      width: 200,
                      child: Divider(
                        thickness: 0.7,
                        color: Colors.black,
                      ),
                    ),
                    ListTile(
                      leading: Image.asset(
                        "assets/premium.png",
                      ),
                      title: Text("Maily Premium"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 213, 110, 59),
                    //fixedSize: const Size(300, 56) ,
                    elevation: 24,
                    shadowColor: const Color.fromARGB(255, 213, 110, 59),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                        side: const BorderSide(
                            color: Color.fromARGB(255, 226, 98, 39), width: 2)),
                  ),
                  onPressed: () {
                    Get.to(() => const Login(),
                        transition: Transition.noTransition,
                        duration: const Duration(seconds: 1));
                    FirebaseAuth.instance.signOut();
                  },
                  child: const Text('Log out')),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(child: AnimatedBottomNavBar(2)),
    );
  }
}
