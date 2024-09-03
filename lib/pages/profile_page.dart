import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mind_sage/pages/dass_page.dart';
import 'package:mind_sage/pages/joyna_page.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final user = FirebaseAuth.instance.currentUser!;

  // Variáveis para armazenar a data e hora do questionário
  String? completedDate;
  String? completedTime;

  // Método para atualizar data e hora de conclusão
  void updateCompletionTime() {
    setState(() {
      final now = DateTime.now();
      completedDate = DateFormat('EEEE, dd/MM/yyyy')
          .format(now); // Formata o dia da semana, dia/mês/ano
      completedTime =
          DateFormat('HH:mm').format(now); // Formata a hora e os minutos
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 30, bottom: 8),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: const Color.fromARGB(255, 56, 183, 247),
                    child: CircleAvatar(
                      radius: 24,
                      backgroundImage: user.photoURL != null
                          ? NetworkImage(user.photoURL!)
                          : AssetImage('lib/Images/logo-larga.jpg')
                              as ImageProvider, // Exibe a foto do Google ou uma imagem padrão
                    ),
                  ),
                  SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.displayName != null
                              ? user.displayName!
                              : user.email ?? 'Email não disponível',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Suas atividades',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.black87,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuestionScreen(
                      onQuestionnaireCompleted: updateCompletionTime,
                    ),
                  ),
                );
              },
              child: Center(
                child: Card(
                  elevation: 7,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Container(
                    color: Colors.white,
                    width: 350,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Como foi sua semana?',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Sumário',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                        Divider(
                          color: Colors.blue,
                          thickness: 2,
                          endIndent: 200,
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Teste 1/4',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Questionário DASS-21.',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    completedDate != null
                                        ? 'Dia: $completedDate, $completedTime'
                                        : 'Questionário não concluído ainda',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Colors.blue[100],
                                  child: Text(
                                    '1',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Update',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => JoynaPage(),
            ),
          );
        },
        child: Icon(
          Icons.add_circle_outline,
          size: 40,
          color: Colors.white,
        ),
        tooltip: 'Increment',
      ),
    );
  }
}
