import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
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
  final List<String> _filePaths = [];

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        _filePaths.add(result.files.first.path!);
      });
    }
  }

  @override
  void dispose() {
    _player?.dispose();
    super.dispose();
  }

  void _togglePlayPause(String filePath) {
    if (_player == null) {
      final player = AudioPlayer();
      player.play(DeviceFileSource(filePath));
      setState(() {
        _player = player;
        _isPlaying = true;
      });
    } else {
      _player!.stop();
      final player = AudioPlayer();
      player.play(DeviceFileSource(filePath));
      setState(() {
        _player = player;
        _isPlaying = true;
      });
    }
  }

  // ignore: non_constant_identifier_names
  void _BotonPlay() {
      if (_isPlaying) {
        _player?.pause();
      } else {
        _player?.resume();
      }
      setState(() {
        _isPlaying = !_isPlaying;
      });
    }
  void _stopAudio() {
    if (_player != null && _isPlaying) {
      _player?.stop();
      _player = null;
      setState(() {
        _isPlaying = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 0, 212),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: _pickFile,
                child: const Text('Escoja un archivo'),
              ),
              const SizedBox(height: 16),
              for (var filePath in _filePaths)
                ElevatedButton(
                  onPressed: () => _togglePlayPause(filePath),
                  child: Text(
                      filePath.split('/').last), // Display only the file name
                ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _stopAudio,
                child: const Icon(Icons.stop),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FractionallySizedBox(
        widthFactor: 0.2,
        heightFactor: 0.1,
        child: FloatingActionButton(
          onPressed: _BotonPlay,
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
