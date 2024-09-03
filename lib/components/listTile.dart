import 'package:flutter/material.dart';

class HealthConditionsPage extends StatefulWidget {
  @override
  _HealthConditionsPageState createState() => _HealthConditionsPageState();
}

class _HealthConditionsPageState extends State<HealthConditionsPage> {
  // Variáveis booleanas para controlar os estados dos checkboxes
  bool diabetes = false;
  bool hipertensao = false;
  bool cancer = false;
  bool outro = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doenças pré-existentes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título da seção
            Text(
              'Doenças pré-existentes',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Checkbox para Diabetes
            CheckboxListTile(
              title: Text('Diabetes'),
              value: diabetes,
              onChanged: (bool? value) {
                setState(() {
                  diabetes = value!;
                });
              },
            ),
            // Checkbox para Hipertensão
            CheckboxListTile(
              title: Text('Hipertensão'),
              value: hipertensao,
              onChanged: (bool? value) {
                setState(() {
                  hipertensao = value!;
                });
              },
            ),
            // Checkbox para Câncer
            CheckboxListTile(
              title: Text('Câncer'),
              value: cancer,
              onChanged: (bool? value) {
                setState(() {
                  cancer = value!;
                });
              },
            ),
            // Checkbox para Outro
            CheckboxListTile(
              title: Text('Outro'),
              value: outro,
              onChanged: (bool? value) {
                setState(() {
                  outro = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}