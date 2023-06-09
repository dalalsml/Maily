
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maily/screens/connexion.dart';
import 'package:maily/screens/login.dart';

import 'SignUp.dart';


class Inscription extends StatefulWidget {
  const Inscription({super.key});

  @override
   State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription>{
   @override
   Widget build(BuildContext context) => Scaffold(
   body: StreamBuilder<User?>(
    stream:  FirebaseAuth.instance.authStateChanges(),
    builder: (context, snapshot) {
      
       if (snapshot.hasData){
        return const Home();
      }
      else{
        return const SignUp();
      }
    },
   ),
   );
}