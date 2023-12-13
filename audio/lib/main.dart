import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AudioPlayer? _player;
  bool _isPlaying = false;

  @override
  void dispose() {
    _player?.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (_player == null) {
      final player = AudioPlayer();
      player.play(AssetSource('Intermision.mp3'));
      setState(() {
        _player = player;
        _isPlaying = true;
      });
    } else {
      if (_isPlaying) {
        _player?.pause();
      } else {
        _player?.resume();
      }
      setState(() {
        _isPlaying = !_isPlaying;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Click on the play/pause button to control the audio',
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FractionallySizedBox(
        widthFactor: 0.2,
        heightFactor: 0.1,
        child: FloatingActionButton(
          onPressed: _togglePlayPause,
          tooltip: 'Play/Pause',
          backgroundColor: Colors.green,
          heroTag: true,
          child: _isPlaying
              ? const Icon(Icons.pause, size: 50.0)
              : const Icon(Icons.play_arrow, size: 50.0),
        ),
      ),
    );
  }
}
