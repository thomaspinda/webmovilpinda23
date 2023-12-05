import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Pokemon {
  final String nombre;
  final String tipo;
  final String imagen;
  final String numero;
  Pokemon({required this.nombre, required this.tipo, required this.imagen, required this.numero});
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Pokédek'),
        ),
        body: PokemonCarousel(),
      ),
    );
  }
}

class PokemonCarousel extends StatelessWidget {
  final List<Pokemon> pokemones = [
    Pokemon(nombre: 'Bulbasaur', tipo: 'Planta', imagen: 'assets/bulbasaur.png',numero:'#1'),
    Pokemon(nombre: 'Charmander', tipo: 'Fuego', imagen: 'assets/charmander.png',numero:'#4'),
    Pokemon(nombre: 'Squirtle', tipo: 'Agua', imagen: 'assets/squirtle.png',numero:'#7'),
    Pokemon(nombre: 'Pikachu', tipo: 'electrico', imagen: 'assets/pikachu.png',numero:'#25'),
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
          Text(
            pokemon.numero,
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
    // Puedes definir tus propios colores según los tipos de Pokémon
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
