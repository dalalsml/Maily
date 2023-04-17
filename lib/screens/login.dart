import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maily/screens/FirstPage.dart';
import 'package:maily/screens/SignUp.dart';
import 'package:rive/rive.dart';
import 'dart:ui';
import 'package:get/get.dart';

import 'SignUPappel.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  Icon icon = const Icon(
    Icons.visibility_off,
    color: Colors.black,
  );
  bool hide = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:

      Stack(children: [
        Container(
            child: const RiveAnimation.asset(
          "assets/animations/mailyBackGrd.riv",
          fit: BoxFit.fill,
        )),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
            child: const SizedBox(),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Hero(tag: 'logo', child: Image.asset("assets/logo.png")),
              Hero(
                  tag: 'mailyText',
                  child: Image.asset("assets/MAILY_text.png")),
            ],
          ),
        ),
        Hero(
          tag: 'login',
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            margin: const EdgeInsets.only(top: 320),
            padding: const EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Material(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Enter to your account',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(left: 25, top: 15),
                      child: const Text('E-mail',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 4),
                      child: TextField(
                        controller: _controller1,
                        cursorColor: const Color.fromARGB(255, 226, 98, 39),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                          hintText: 'Enter your E-mail...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(left: 25, top: 19),
                      child: const Text('Password',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 4),
                      child: TextField(
                        controller: _controller2,
                        cursorColor: const Color.fromARGB(255, 226, 98, 39),
                        obscureText: hide,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hide = !hide;
                                  icon = hide
                                      ? const Icon(
                                          Icons.visibility_off,
                                          color: Colors.black,
                                        )
                                      : const Icon(
                                          Icons.visibility,
                                          color: Colors.black,
                                        );
                                });
                                signIn();
                              },
                              icon: icon),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                          hintText: 'Enter your password...',
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: const EdgeInsets.only(right: 20),
                      child: TextButton(
                          onPressed: signIn,
                          child: const Text(
                            'Forgot the password ?',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          )),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 213, 110, 59),
                          fixedSize: const Size(300, 56),
                          elevation: 24,
                          shadowColor: const Color.fromARGB(255, 213, 110, 59),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                              side: const BorderSide(
                                  color: Color.fromARGB(255, 226, 98, 39),
                                  width: 2)),
                        ),
                        onPressed: signIn,
                       
                        child: const Text('Log in to Maily')),
                    TextButton(
                        onPressed: () {
                          Get.to(() => const Inscription(),
                              transition: Transition.noTransition,
                              duration: const Duration(seconds: 1));
                        },
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Column(children: [
            const SizedBox(
              height: 330,
            ),
            GestureDetector(
              onVerticalDragUpdate: (details) {
                Get.to(() => const FirstPage(),
                    transition: Transition.fade,
                    duration: const Duration(seconds: 1));
                ;
              },
              child: Image.asset(
                'assets/line.png',
                width: 200,
              ),
            ),
          ]),
        )
      ]),
    );
  }


Future signIn() async {
 
 
 
  try {
  await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: _controller1.text.trim(), 
    password: _controller2.text.trim() );
    } on FirebaseAuthException catch(e){
      print(e);
    }
   // navig

}

}




