// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sedes Universidad de Los Lagos'),
      ),
      body: Column(
        children: [
          Expanded(
            child: CardList(),
          ),
          ElevatedButton(
            onPressed: () {
              _launchURL();
            },
            child: Text('Más información'),
          ),
        ],
      ),
    );
  }
  _launchURL() async {
    const url = 'https://www.ulagos.cl';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo abrir la URL $url';
    }
  }
}

class CardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CustomCard('Sede Ulagos Osorno', 'Osorno.jpg', () {
          print('Esta es la Sede de Osorno');
        }),
        CustomCard('Sede Ulagos Puerto Montt', 'PM.jpg', () {
          print('Esta es la Sede de Puerto Montt');
        }),
        CustomCard('Sede Ulagos Chiloé', 'Chiloe.jpg', () {
          print('Esta es la Sede de Chiloé');
        }),
      ],
    );
  }
}

class CustomCard extends StatelessWidget {
  final String description;
  final String imagePath;
  final VoidCallback onTap;

  CustomCard(this.description, this.imagePath, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
              height: 150.0,
              width: double.infinity,
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.0),
                  Text(
                    description,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
