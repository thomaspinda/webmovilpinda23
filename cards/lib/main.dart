import 'package:flutter/material.dart';

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
              // Lógica al presionar el botón inferior
              print('Botón inferior presionado');
            },
            child: Text('Más información'),
          ),
        ],
      ),
    );
  }
}

class CardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CustomCard('Sede Ulagos Osorno', 'assets/image1.jpg', () {
          print('Clicked on Card 1');
        }),
        CustomCard('Sede Ulagos Puerto Montt', 'assets/image2.jpg', () {
          print('Clicked on Card 2');
        }),
        CustomCard('Sede Ulagos Chiloé', 'assets/image3.jpg', () {
          print('Clicked on Card 3');
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