import 'package:flutter/material.dart';
import 'package:maily/screens/FirstPage.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart' ;
import 'package:maily/screens/utils.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'screens/utils.dart';

void main() async {  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const Maily_App());
}

class Maily_App extends StatefulWidget {
  const Maily_App({super.key});

  @override
  State<Maily_App> createState() => _Maily_AppState();
}


class _Maily_AppState extends State<Maily_App> {
  @override
  Widget build(BuildContext context) {
    
     return const GetMaterialApp(
      home: FirstPage(),
    );
  }
}
