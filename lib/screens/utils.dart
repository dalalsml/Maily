import 'package:flutter/material.dart';

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar (String? text){
    if (text==null)return;
    final snackBar = SnackBar(content: Text(text),backgroundColor: Colors.red);
    messengerKey.currentState!
    ..removeCurrentSnackBar()
    ..showSnackBar(snackBar);
  }

   static showSnackBargray (String? text){
    if (text==null)return;
    final snackBar = SnackBar(content: Text(text),backgroundColor: Color.fromARGB(255, 197, 227, 210));
    messengerKey.currentState!
    ..removeCurrentSnackBar()
    ..showSnackBar(snackBar);
  }
}