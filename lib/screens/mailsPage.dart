import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maily/screens/FirstPage.dart';
import 'package:maily/screens/SignUp.dart';
import 'package:maily/screens/dashboard.dart';
import 'package:maily/screens/login.dart';

import 'dart:ui';
import 'package:get/get.dart';

class HEY extends StatefulWidget {
  const HEY({super.key});

  @override
  State<HEY> createState() => _HEYState();
}

class _HEYState extends State<HEY> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Dashboard();
            } else {
              return const Login();
            }
          },
        ),
      );
}
