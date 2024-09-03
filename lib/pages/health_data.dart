import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mind_sage/components/listTile.dart';
import 'package:mind_sage/components/my_button.dart';
import 'package:mind_sage/components/my_textfield.dart';
import 'package:mind_sage/pages/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HealthPage extends StatefulWidget {
  HealthPage({super.key});

  @override
  _HealthPageState createState() => _HealthPageState();
}

class _HealthPageState extends State<HealthPage> {
  bool diabetes = false;
  bool hipertensao = false;
  bool cancer = false;
  bool outro = false;

  final user = FirebaseAuth.instance.currentUser!;
  String? selectedCivilStatus;
  String? selectedGender;

  @override
  void initState() {
    super.initState();
    _checkIfPersonalDataFormCompleted1();
  }

  // Método para verificar se o formulário foi preenchido
  Future<void> _checkIfPersonalDataFormCompleted1() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isFormCompleted =
        prefs.getBool('personalDataFormCompleted1') ?? false;

    if (isFormCompleted) {
      // Redireciona para a próxima página se o formulário já foi preenchido
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => UserProfile(),
        ),
      );
    }
  }

  // Método para marcar o formulário como preenchido
  Future<void> _markPersonalDataFormCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('personalDataFormCompleted', true);
  }

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dados Médicos...',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(
              Icons.cancel,
              color: Colors.black87,
              size: 40,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  "${user.displayName}, preencha os campos para continuar.",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(height: 7),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 27.0),
                child: Text(
                  "Prática de atividades físicas",
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: SizedBox(
                  width: 300,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.5,
                        ),
                      ),
                      fillColor: Color.fromARGB(29, 0, 162, 255),
                      filled: true,
                      labelText: 'Selecione...',
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                    ),
                    value: selectedCivilStatus,
                    items: <String>[
                      'Sedentário',
                      'Pratico as vezes',
                      'Ativo fisicamente',
                      'Atleta'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCivilStatus = newValue!;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 27.0),
                child: Text(
                  "Funcionamento do intestino",
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: SizedBox(
                  width: 300,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.5,
                        ),
                      ),
                      fillColor: Color.fromARGB(29, 0, 162, 255),
                      filled: true,
                      labelText: 'Selecione...',
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                    ),
                    value: selectedGender,
                    items: <String>[
                      'Ruim',
                      'Mais ou menos',
                      'Bom',
                      'Muito bom',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedGender = newValue!;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Doenças pré-existentes',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    CheckboxListTile(
                      title: Text(
                        'Diabetes',
                      ),
                      value: diabetes,
                      activeColor: Colors.blue,
                      onChanged: (bool? value) {
                        setState(() {
                          diabetes = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text(
                        'Hipertensão',
                      ),
                      value: hipertensao,
                      activeColor: Colors.blue,
                      onChanged: (bool? value) {
                        setState(() {
                          hipertensao = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text(
                        'Câncer',
                      ),
                      value: cancer,
                      activeColor: Colors.blue,
                      onChanged: (bool? value) {
                        setState(() {
                          cancer = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text(
                        'Outro',
                      ),
                      value: outro,
                      activeColor: Colors.blue,
                      onChanged: (bool? value) {
                        setState(() {
                          outro = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: GestureDetector(
                  onTap: () async {
                    await _markPersonalDataFormCompleted();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserProfile(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.blue[700],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        'Próximo',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
