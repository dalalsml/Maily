import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:maily/screens/login.dart';
import 'package:get/get.dart';
import 'package:maily/screens/mailsPage.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              width: double.maxFinite,
              height: double.maxFinite,
              child: Image.asset(
                "assets/back.png",
                fit: BoxFit.cover,
              )),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: const SizedBox(),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(tag: 'logo', child: Image.asset("assets/logo.png")),
                Hero(
                    tag: 'mailyText',
                    child: Image.asset(
                      "assets/MAILY_text.png",
                    )),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onVerticalDragUpdate: (details) {
                    Get.to(() => const HEY(),
                        transition: Transition.downToUp,
                        duration: const Duration(seconds: 1));
                  },
                  child: Image.asset('assets/swipe.png'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
