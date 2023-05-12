import 'dart:ui';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maily/screens/utils.dart';

class ForgotPasswordPage extends StatefulWidget {
 
  const ForgotPasswordPage({super.key});

 @override 
   State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class  _ForgotPasswordPageState extends State<ForgotPasswordPage> {
final formKey = GlobalKey<FormState>();
final emailController = TextEditingController(); 

@override
void dispose (){
  emailController.dispose();
  super.dispose();
}

@override 
Widget build(BuildContext context) => Scaffold(
  
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
      Padding (
        padding:  EdgeInsets.all(16), 
        child: Form (
          key: formKey,
          child: Column (
            mainAxisAlignment:  MainAxisAlignment.center,
            children:  [
              Text(
                'Receive an email to\nreset your password',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20), 
              TextFormField(
                
                 controller: emailController,
                 cursorColor: const Color.fromARGB(255, 226, 98, 39),
                 textInputAction: TextInputAction.done,
                 decoration: InputDecoration(label: Text("E-mail",style: TextStyle(color: Colors.black),),
                 enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ), ),
                 autovalidateMode:  AutovalidateMode.onUserInteraction,
                 validator: (email) => 
                 email != null && !EmailValidator.validate(email)
                 ? 'Enter a valid email'
                 : null,


              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
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
                
                icon: Icon(Icons.email_outlined),
                label: Text(
                  'Reset Password',
                  style: TextStyle(fontSize: 24),
                ),
                
                onPressed: resetPassword,

              )
            ],
          ),
          )
        
         ),
    ],
  ),
);

Future resetPassword () async {
try{
await FirebaseAuth.instance
.sendPasswordResetEmail(email: emailController.text.trim()); 

Utils.showSnackBargray('Password Reset Email Sent');
} on FirebaseAuthException catch (e){
  print(e);
  Utils.showSnackBar(e.message);
}
}
}