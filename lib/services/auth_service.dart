import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:mind_sage/pages/auth_page.dart';
class AuthService {
  GoogleSignIn signIn = new GoogleSignIn();

  // google sign in
  Future<void> googleSignin(BuildContext context) async {
    try {
      var gUser = await signIn.signIn();
      print(gUser);

      // Navegar para a HomePage após o login
      if (gUser != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => AuthPage(),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
