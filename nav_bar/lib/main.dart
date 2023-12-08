import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(MyApp());
}

class Pokemon {
  final String nombre;
  final String tipo;
  final String imagen;

  Pokemon({required this.nombre, required this.tipo, required this.imagen});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon Carousel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    PokemonCarousel(),
    Perfil(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BottomNavBar'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'Carrusel',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: 'Imagen y botón',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
class PokemonCarousel extends StatelessWidget {
  final List<Pokemon> pokemones = [
    Pokemon(nombre: 'Bulbasaur', tipo: 'Planta', imagen: 'assets/bulbasaur.png'),
    Pokemon(nombre: 'Charmander', tipo: 'Fuego', imagen: 'assets/charmander.png'),
    Pokemon(nombre: 'Squirtle', tipo: 'Agua', imagen: 'assets/squirtle.png'),
    Pokemon(nombre: 'Pikachu', tipo: 'Electrico', imagen: 'assets/pikachu.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 400.0,
        enlargeCenterPage: true,
        autoPlay: true,
      ),
      items: pokemones.map((pokemon) {
        return Builder(
          builder: (BuildContext context) {
            return PokemonCard(pokemon: pokemon);
          },
        );
      }).toList(),
    );
  }
}
class Perfil extends StatefulWidget {
  @override
  Imagen createState() => Imagen();
}
class Imagen extends State<Perfil> {
  bool _showImage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _showImage ? Image.asset('assets/pikachu.gif') : Container(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _showImage = !_showImage;
                });
              },
              child: Text(_showImage ? 'Ocultar Imagen' : 'Mostrar Imagen'),
            ),
          ],
        ),
      ),
    );
  }
}
class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  PokemonCard({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.asset(
            pokemon.imagen,
            height: 200.0,
            width: 200.0,
          ),
          SizedBox(height: 10.0),
          Text(
            pokemon.nombre,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5.0),
          Chip(
            label: Text(
              pokemon.tipo,
              style: TextStyle(color: getColorForType(pokemon.tipo)),
            ),
            backgroundColor: Colors.grey[300],
          ),
        ],
      ),
    );
  }

  Color getColorForType(String type) {
    switch (type.toLowerCase()) {
      case 'planta':
        return Colors.green;
      case 'fuego':
        return Colors.orange;
      case 'agua':
        return Colors.blue;
      case 'electrico':
        return Colors.yellow;
      default:
        return Colors.grey;
    }
  }
}
