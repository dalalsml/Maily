import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../main.dart';

class PageNew extends StatefulWidget {
  const PageNew({super.key});

  @override
  State<PageNew> createState() => _PageNewState();
}

class _PageNewState extends State<PageNew> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container());
  }
}
