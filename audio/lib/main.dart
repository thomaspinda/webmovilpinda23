import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

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
  String _filePath = "";

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        _filePath = result.files.first.path!;
      });
    }
  }

  @override
  void dispose() {
    _player?.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (_player == null) {
      final player = AudioPlayer();
      player.play(DeviceFileSource(_filePath));
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(children: [
            ElevatedButton(
              onPressed: _pickFile,
              child: const Text('Escoja un archivo'),
            ),
          ]),
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
