// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

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
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
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
  int _currentSongIndex = 0;
  AudioPlayer? _player;
  bool _isPlaying = false;
  List<AudioButton> _audioButtons = [];

  @override
  void initState() {
    super.initState();
    _loadSavedFiles();
  }

  Future<void> _loadSavedFiles() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      final savedButtons = prefs.getStringList('audioButtons') ?? [];
      _audioButtons = savedButtons.map((buttonData) {
        final parts = buttonData.split('|');
        return AudioButton(
          name: parts[0],
          autorname: parts[1],
          filePath: parts[2],
          backgroundImage: parts[3],
        );
      }).toList();
    });
  }

  Future<void> _saveButtons() async {
    final prefs = await SharedPreferences.getInstance();
    final savedButtons = _audioButtons
        .map((button) =>
            '${button.name}|${button.autorname}|${button.filePath}|${button.backgroundImage}')
        .toList();
    prefs.setStringList('audioButtons', savedButtons);
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowMultiple: false,
    );

    if (result != null) {
      String filePath = result.files.first.path!;
      await _showCustomButtonDialog(filePath);
    }
  }

  Future<void> _showCustomButtonDialog(String filePath) async {
    final TextEditingController _customButtonNameController =
        TextEditingController();
    final TextEditingController _customButtomAuthorController =
        TextEditingController();
    File? _customButtonImage;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Configuración del botón'),
          content: Column(
            children: [
              const Text('Ingrese el nombre de la canción:'),
              TextField(
                controller: _customButtonNameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              const Text('Ingrese el nombre del autor'),
              TextField(
                controller: _customButtomAuthorController,
                decoration: const InputDecoration(labelText: 'Autor'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final pickedFile = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);

                  if (pickedFile != null) {
                    setState(() {
                      _customButtonImage = File(pickedFile.path);
                    });
                  }
                },
                child: const Text('Seleccionar imagen'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _saveCustomButton(
                  _customButtonNameController.text.isNotEmpty
                      ? _customButtonNameController.text
                      : 'Sin nombre',
                  _customButtomAuthorController.text.isNotEmpty
                      ? _customButtomAuthorController.text
                      : 'Artista desconocido',
                  filePath,
                  _customButtonImage,
                );
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void _saveCustomButton(
      String name, String autorname, String filePath, File? backgroundImage) {
    setState(() {
      final newButton = AudioButton(
        name: name,
        autorname: autorname,
        filePath: filePath,
        backgroundImage: '',
      );
      if (backgroundImage != null) {
        newButton.backgroundImage = backgroundImage.path;
      }
      _audioButtons.add(newButton);
      _saveButtons();
    });
  }

  void _togglePlayPause(AudioButton button) {
    if (_player == null) {
      final player = AudioPlayer();
      player.play(DeviceFileSource(button.filePath));
      setState(() {
        _player = player;
        _isPlaying = true;
      });
    } else {
      _player!.stop();
      final player = AudioPlayer();
      player.play(DeviceFileSource(button.filePath));
      setState(() {
        _player = player;
        _isPlaying = true;
      });
    }
  }

  void _playNextSong() {
    if (_audioButtons.isNotEmpty) {
      final nextIndex = (_currentSongIndex + 1) % _audioButtons.length;
      final nextSong = _audioButtons[nextIndex];
      if (_player != null) {
        _player!.stop();
      }
      final player = AudioPlayer();
      player.play(DeviceFileSource(nextSong.filePath));
      setState(() {
        _player = player;
        _isPlaying = true;
        _currentSongIndex = nextIndex;
      });
    }
  }

  void _playPreviousSong() {
    if (_audioButtons.isNotEmpty) {
      final nextIndex = (_currentSongIndex - 1) % _audioButtons.length;
      final nextSong = _audioButtons[nextIndex];
      if (_player != null) {
        _player!.stop();
      }
      final player = AudioPlayer();
      player.play(DeviceFileSource(nextSong.filePath));
      setState(() {
        _player = player;
        _isPlaying = true;
        _currentSongIndex = nextIndex;
      });
    }
  }

  void _botonplay() {
    if (_isPlaying) {
      _player?.pause();
    } else {
      _player?.resume();
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  Widget _buildAudioButton(AudioButton button) {
    return Column(
      children: [
        const SizedBox(height: 10),
        SizedBox(
          width: 450,
          height: 70,
          child: GestureDetector(
            onLongPress: () {
              _showPopupMenu(button);
            },
            child: Stack(
              children: [
                ElevatedButton(
                  onPressed: () => _togglePlayPause(button),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Container(
                      width: 450,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        image: DecorationImage(
                          image: button.backgroundImage.isNotEmpty
                              ? FileImage(File(button.backgroundImage))
                              : const AssetImage('assets/default_image.jpg')
                                  as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        button.name,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 0, 255, 8),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        button.autorname,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 0, 255, 8),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showPopupMenu(AudioButton button) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eliminar botón'),
          content:
              const Text('¿Estás seguro de que deseas eliminar este botón?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _stopAndRemoveButton(button);
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  void _stopAndRemoveButton(AudioButton button) {
    if (_player != null && _isPlaying) {
      _player!.stop();
      setState(() {
        _isPlaying = false;
      });
    }
    setState(() {
      _audioButtons.remove(button);
      _saveButtons();
    });
  }

  Widget _buildBottomControls() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 100,
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(40)),
        ), // Color de fondo
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.skip_previous,
                  size: 40, color: Colors.white),
              onPressed: () {
                _playPreviousSong();
              },
            ),
            FloatingActionButton(
              onPressed: _botonplay,
              tooltip: 'Play/Pause',
              backgroundColor: Colors.green,
              heroTag: true,
              child: _isPlaying
                  ? const Icon(Icons.pause, size: 50.0)
                  : const Icon(Icons.play_arrow, size: 50.0),
            ),
            IconButton(
              icon: const Icon(Icons.skip_next, size: 40, color: Colors.white),
              onPressed: () {
                _playNextSong();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.blue,
      elevation: 0,
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Container(
            width: 200.0,
            height: 200.0,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/LOGO.png'),
            ),
            
          ),
        ),
      ),
    ),

      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 21, 56, 255),
        child: Column(
          children: [
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Escoja un archivo'),
              onTap: (){
                Navigator.pop(context);
                _pickFile();
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
                Colors.blue,
                Color.fromARGB(255, 0, 201, 7),
                Color.fromARGB(255, 0, 201, 7),

            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _audioButtons.length,
                        itemBuilder: (context, index) =>
                            _buildAudioButton(_audioButtons[index]),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            _buildBottomControls(),
          ],
        ),
      ),
    );
  }
}

class AudioButton {
  final String name;
  final String autorname;
  final String filePath;
  String backgroundImage;

  AudioButton({
    required this.name,
    required this.autorname,
    required this.filePath,
    this.backgroundImage = '',
  });
}
