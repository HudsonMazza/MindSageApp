import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: JoynaPage(),
    );
  }
}

class JoynaPage extends StatelessWidget {
  // Método para lançar a URL
  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 90,
              backgroundColor: const Color.fromARGB(255, 56, 183, 247),
              child: CircleAvatar(
                radius: 84,
                backgroundImage: AssetImage('lib/Images/joyna.png'),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Dra. Joyna Castro',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Farmacêutica Clínica Integrativa',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    ElevatedButton.icon(
                      icon: Icon(Icons.chat, color: Colors.blue),
                      label: Text(
                        'WhatsApp',
                        style: TextStyle(
                          color: Colors.blue[800],
                        ),
                      ),
                      onPressed: () {
                        _launchURL(
                            'https://web.whatsapp.com/send?autoload=1&app_absent=0&phone=559192650506&text');
                      },
                    ),
                    Text('@dra.joynacastro',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500
                    ),
                    ),
                  ],
                ),
                SizedBox(width: 16),
                Column(
                  children: [
                    ElevatedButton.icon(
                      icon: Icon(Icons.camera_alt, color: Colors.blue),
                      label: Text(
                        'Instagram',
                        style: TextStyle(
                          color: Colors.blue[800],
                        ),
                      ),
                      onPressed: () {
                        _launchURL(
                            'https://www.instagram.com/dra.joynacastro/');
                      },
                    ),
                    Text('+55 91 9265-0506',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500
                    ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 24),
            Text(
              'RECOMENDAÇÃO',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Baseado no rastreamento atual de saúde mental realizado através de aplicativo mobile de sugestão de práticas integrativas, sugere-se uma avaliação especializada para melhor acompanhamento através de uma consulta nos links acima.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
