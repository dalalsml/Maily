import 'dart:ui';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maily/screens/utils.dart';
import 'package:rive/rive.dart';
import 'package:maily/screens/login.dart';
import 'package:maily/screens/FirstPage.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _emailController = TextEditingController();
  final _passController1 = TextEditingController();
  final _passController2 = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Icon icon = const Icon(
    Icons.visibility_off,
    color: Colors.black,
  );
  bool hide = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
            width: double.maxFinite,
            height: double.maxFinite,
            child: Image.asset(
              "assets/back.png",
              fit: BoxFit.cover,
            )),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
            child: const SizedBox(),
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            children: [
              Hero(
                  tag: 'logo',
                  child: Image.asset(
                    "assets/logo.png",
                    width: 120,
                  )),
              Hero(
                  tag: 'mailyText',
                  child: Image.asset(
                    "assets/MAILY_text.png",
                    width: 120,
                  )),
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
            margin: const EdgeInsets.only(top: 220),
            padding: const EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Material(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Create new account',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
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
                        child: TextFormField(
                          controller: _emailController,
                          cursorColor: const Color.fromARGB(255, 226, 98, 39),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black),
                            ),
                            hintText: 'Enter your E-mail...',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black),
                            ),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (email) =>
                              email != null && !EmailValidator.validate(email)
                                  ? 'Enter a valid email'
                                  : null,
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(left: 25, top: 15),
                        child: const Text('Phone number',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 4),
                          child: IntlPhoneField(
                            initialCountryCode: AutofillHints.countryCode,
                            cursorColor: const Color.fromARGB(255, 226, 98, 39),
                            decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.black),
                              ),
                              hintText: 'Phone number...',
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.black),
                              ),
                            ),
                          )),
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
                        child: TextFormField(
                          controller: _passController1,
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
                                  signUp(); //
                                },
                                icon: icon),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black),
                            ),
                            hintText: 'Enter your password...',
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black),
                            ),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value != null && value.length < 6
                                  ? 'Enter min 6 characters'
                                  : null,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, top: 24, bottom: 27),
                        child: TextField(
                          controller: _passController2,
                          cursorColor: const Color.fromARGB(255, 226, 98, 39),
                          obscureText: hide,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black),
                            ),
                            hintText: 'Confirm password...',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const SizedBox(
                              width: 60,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 213, 110, 59),
                                  fixedSize: const Size(69, 69),
                                  elevation: 24,
                                  shadowColor:
                                      const Color.fromARGB(255, 213, 110, 59),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      side: const BorderSide(
                                          color:
                                              Color.fromARGB(255, 226, 98, 39),
                                          width: 2)),
                                ),
                                onPressed: () {
                                  signUp();
                                },
                                child: const Icon(Icons.check)),
                            TextButton(
                                onPressed: () {
                                  Get.to(() => const Login(),
                                      transition: Transition.noTransition,
                                      duration: const Duration(seconds: 1));
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Column(children: [
            const SizedBox(
              height: 230,
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

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passController1.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }
  }
}
