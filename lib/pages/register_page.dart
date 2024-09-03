import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mind_sage/components/my_button.dart';
import 'package:mind_sage/components/my_textfield.dart';
import 'package:mind_sage/pages/auth_page.dart';
import 'package:mind_sage/services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Text editing controllers - controladores de edição do texto
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  // sign user up method
  void signUserUp() async {
    // show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    // try create the user
    try {
      // check if password is confirmed
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      }
    } on FirebaseAuthException catch (e) {
      //pop the loading circle
      Navigator.pop(context);
      // EMAIL ERRADO
      if (e.code == 'user-not-found') {
        wrongEmailMessage();
      }

      // SERNHA ERRADA
      else if (e.code == 'wrong-password') {
        wrongPasswordMessage();
      }
    }

    //pop the loading circle
    Navigator.pop(context);
  }

  // WRONG EMAIL MESSAGE POPUP
  void wrongEmailMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            backgroundColor: Color.fromARGB(255, 8, 31, 97),
            title: Text(
              "Esse E-mail não existe...",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );
        });
  }

  // WRONG PASSWORD MESSAGE POPUP
  void wrongPasswordMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            backgroundColor: Color.fromARGB(255, 8, 31, 97),
            title: Text(
              "Sua senha está errada...",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 35,
                ),

                // Logo of branch Mind Sage - Foto da marca Mind Sage
                Image.asset(
                  'lib/Images/logo.png',
                  height: 100,
                ),

                const SizedBox(
                  height: 30,
                ),

                // welcome back, you've been missed! - bem vindo, sentimos sua falta!
                Text(
                  'Bem vindo de volta, faça seu Login!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 15,
                  ),
                ),

                const SizedBox(
                  height: 12,
                ),

                // username textfield - campo de username
                MyTextField(
                  controller: emailController,
                  labelText: 'Insira seu E-mail',
                  obscureText: false,
                ),

                const SizedBox(
                  height: 10,
                ),

                // password textfield - campo de senha
                MyTextField(
                  controller: passwordController,
                  labelText: 'Insira sua Senha',
                  obscureText: true,
                ),

                const SizedBox(
                  height: 10,
                ),

                MyTextField(
                  controller: confirmPasswordController,
                  labelText: 'Confirme sua Senha',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 5,
                ),

                // forgot password? - esqueceu sua senha?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Esqueceu sua senha?',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14.5,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                // sign in button - botão de logar
                MyButton(
                  onTap: signUserUp,
                ),

                const SizedBox(
                  height: 25,
                ),

                // or continue with... - ou continuar com...
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[700],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Ou continue com...',
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ), //
                const SizedBox(
                  height: 15,
                ),
                // google sing in button - logar com o google
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => AuthPage().signInWithGoogle(context),
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 3.5,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.grey[200], //
                        ),
                        child: Image.asset(
                          'lib/Images/google.png',
                          height: 60,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 10,
                ),

                // not a member? register now! - não tem cadastro? cadastre-se agora!

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Já tem uma conta?',
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Clique aqui!",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.5,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
