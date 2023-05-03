import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:maily/screens/utils.dart';

import 'connexion.dart';

class VerifyEmailPage extends StatefulWidget {
 
  const VerifyEmailPage({super.key});

 @override 
   State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class  _VerifyEmailPageState extends State<VerifyEmailPage> {
bool isEmailVerified = false ;
Timer? timer;
@override
void initState (){
super.initState();

  isEmailVerified=FirebaseAuth.instance.currentUser!.emailVerified;
  if (!isEmailVerified){
    SendVerificationEmail();

    timer =Timer.periodic(
      Duration(seconds: 3),
      (_) => checkEmailVerified(),
    );
  }
}


void dispose() {
  timer?.cancel();
  super.dispose();
  timer = null;
}


Future checkEmailVerified() async {
  await FirebaseAuth.instance.currentUser!.reload();
  
  setState((){
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
  });

  if(isEmailVerified) timer?.cancel();
}
 
 Future SendVerificationEmail () async {
  final user =FirebaseAuth.instance.currentUser;
  try {
    await user!.sendEmailVerification();
  } catch (e) {
    if (e is FirebaseAuthException) {
      if (e.code == 'too-many-requests') {
        print('Too many requests. Waiting for 1 minute...');
        await Future.delayed(Duration(minutes: 1));
      } else {
        print('An error occurred while sending email verification. Error code: ${e.code}');
      }
    } else {
      print('An error occurred while sending email verification: $e');
    }
  }

 }
 @override
  Widget build(BuildContext context) => isEmailVerified
  ? Home()
  : Scaffold(
    appBar: AppBar(
      title: Text('Verify Email'),
    ), 
    body: Padding (
    padding: EdgeInsets.all(16),
   /* child: Column(
      children: [
        Text(
          'A verification email has been sent to your email. ',
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 24),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom (
            minimumSize: Size.fromHeight(50),
          ),
           onPressed: (){},
           icon: Icon(Icons.email, size: 32), 
           label: Text (
            
           ),
          )
      ]
      ),*/
    )
  ); 
   


 

}