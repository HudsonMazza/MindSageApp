import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mind_sage/components/my_button.dart'; // Certifique-se de que o caminho está correto
import 'package:mind_sage/pages/health_data.dart';
import 'package:mind_sage/pages/profile_page.dart';

class ResultsScreen extends StatelessWidget {
  final int depressionScore;
  final int anxietyScore;
  final int stressScore;

  ResultsScreen({
    required this.depressionScore,
    required this.anxietyScore,
    required this.stressScore,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildResultButton(
              context,
              'Depressão',
              depressionScore,
              [9, 13, 20, 27],
            ),
            SizedBox(height: 16),
            _buildResultButton(
              context,
              'Ansiedade',
              anxietyScore,
              [7, 9, 14, 19],
            ),
            SizedBox(height: 16),
            _buildResultButton(
              context,
              'Estresse',
              stressScore,
              [14, 18, 25, 33],
            ),
            SizedBox(height: 32), // Espaço para o botão adicional

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserProfile(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  color: Colors.blue[700],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'Voltar',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultButton(
    BuildContext context,
    String category,
    int score,
    List<int> thresholds,
  ) {
    return ElevatedButton(
      onPressed: () => _showResult(context, category, score, thresholds),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        minimumSize: Size(double.infinity, 50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 10),
          Text(
            'Ver resultado de $category',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  void _showResult(
      BuildContext context, String category, int score, List<int> thresholds) {
    String level = _getLevel(score, thresholds);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Resultado de $category',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          content: Text('Seu nível de $category é: $level',
              style: TextStyle(fontSize: 18)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK',
                  style: TextStyle(fontSize: 16, color: Colors.blue)),
            ),
          ],
        );
      },
    );
  }

  String _getLevel(int score, List<int> thresholds) {
    if (score <= thresholds[0]) {
      return 'Normal';
    } else if (score <= thresholds[1]) {
      return 'Leve';
    } else if (score <= thresholds[2]) {
      return 'Moderado';
    } else if (score <= thresholds[3]) {
      return 'Severo';
    } else {
      return 'Muito severo';
    }
  }
}
