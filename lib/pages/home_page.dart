import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue, // Define a cor da AppBar
        actions: [
        IconButton(
          onPressed: signUserOut,
           icon: Icon(Icons.logout,),
           ),
        ],
      ),
      body: Center(child: Text("LOGGED IN AS "+user.email!)),
    );
  }
}