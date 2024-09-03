import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mind_sage/pages/home_page.dart';
import 'package:mind_sage/pages/login_or_register_page.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthPage extends StatelessWidget {
  AuthPage({super.key});

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // Se o login foi cancelado
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Aqui, garanta que o token obtido seja válido para seu projeto Firebase
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      // Exibir mensagem de erro no aplicativo
      print('Erro ao autenticar com o Google: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Exibir um indicador de progresso enquanto espera pela conexão do stream
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Exibir mensagem de erro se houver algum problema com o stream
            return Center(child: Text('Algo deu errado!'));
          } else if (snapshot.hasData) {
            // Usuário autenticado
            return HomePage();
          } else {
            // Usuário não autenticado
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
