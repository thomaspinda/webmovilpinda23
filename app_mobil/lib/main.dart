import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: MyWidget(),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color.fromARGB(255, 0, 108, 196), Colors.lightBlue],
          
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 340,
            height:60,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(color: Colors.white),
            ),
            child: TextFormField(
              decoration: const InputDecoration(
                iconColor: Colors.white,
                prefixIcon: Icon(Icons.mail),
                hintText: 'Nombre de usuario' ,
                
                contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              ),
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
          const SizedBox(height: 16.0),

          Container(
            width: 340,
            height:60,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(4.0),
            ),
            
            child: TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock),
                hintText: 'Contraseña',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              ),
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const home()),
            );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Color de fondo del botón
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0), // Radio del borde del botón
              ),
              elevation: 5.0, // Altura de la sombra del botón
            ),
            child: const Text(
              'Ingresar',
              style: TextStyle(
                fontSize: 18.0, // Tamaño del texto dentro del botón
                color: Colors.white, // Color del texto dentro del botón
                
              ),

            ),
          ),
        ],
      ),
    );
  }
}
// ignore: camel_case_types
class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Segunda Página'),
      ),
      body: const Center(
        child: Text('Contenido de la segunda página'),
      ),
    );
  }
}