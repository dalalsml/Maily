import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/gestures.dart';
import 'package:maily/screens/login.dart';
import 'package:get/get.dart';
import 'package:maily/screens/mailsPage.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -1),
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
            height: double.infinity,
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                _controller.value -=
                    details.primaryDelta! / context.size!.height;
              },
              onVerticalDragEnd: (details) {
                if (_controller.value < 0.1) {
                  _controller.reverse();
                } else {
                  Get.to(() => const HEY(),
                      transition: Transition.downToUp,
                      duration: const Duration(seconds: 1));
                }
              },
              child: SlideTransition(
                position: _offsetAnimation,
                child: Image.asset('assets/swipe.png'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
