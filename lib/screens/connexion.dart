
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
   State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>{
  final user= FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Home'),
    ),
    body:  Padding(padding: EdgeInsets.all(32),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:  [
        const Text(
          'Signed In as',
          style:  TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        Text(
          user.email!,
          style: const TextStyle(fontSize: 20),
        ),
         SizedBox(height: 40),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            minimumSize: Size.fromHeight(50),
          ),
          icon: const Icon(Icons.arrow_back, size: 32),
          label: const Text(
            'Sign Out',
            style: TextStyle(fontSize: 24),
          ),
          onPressed: ()=> FirebaseAuth.instance.signOut(),
          )
        
      ],

    ),
    )
  );

    }
 