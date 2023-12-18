import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        primarySwatch: Colors.green,
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
  List<String> _filePaths = [];
  final TextEditingController _customButtonNameController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSavedFiles();
  }

  Future<void> _loadSavedFiles() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _filePaths = prefs.getStringList('filePaths') ?? [];
    });
  }

  Future<void> _saveFiles() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('filePaths', _filePaths);
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowMultiple: false,
    );

    if (result != null) {
      String filePath = result.files.first.path!;
      await _showCustomButtonNameDialog(filePath);
    }
  }

  Future<void> _showCustomButtonNameDialog(String filePath) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Nombre personalizado'),
          content: Column(
            children: [
              const Text('Ingrese un nombre personalizado para el botón:'),
              TextField(
                controller: _customButtonNameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
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
                _saveCustomButtonName(filePath);
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void _saveCustomButtonName(String filePath) {
    setState(() {
      String customButtonName = _customButtonNameController.text.isNotEmpty
          ? _customButtonNameController.text
          : 'Reproducir';

      // Agregar el nombre personalizado y la ruta del archivo a la lista
      _filePaths.add('$customButtonName|$filePath');

      // Limpiar el controlador después de guardar
      _customButtonNameController.clear();

      // Guardar la lista actualizada
      _saveFiles();
    });
  }

  void _togglePlayPause(String filePathWithCustomName) {
    final parts = filePathWithCustomName.split('|');
    if (parts.length == 2) {
      String filePath = parts[1];

      if (_player == null) {
        final player = AudioPlayer();
        player.play(DeviceFileSource(filePath));
        setState(() {
          _player = player;
          _isPlaying = true;
        });
       Navigator.push(
         context,
         MaterialPageRoute(builder: (context) => NowPlayingScreen(filePathWithCustomName)),
       );
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

  void _stopAudio() {
    if (_player != null && _isPlaying) {
      _player?.stop();
      _player = null;
      setState(() {
        _isPlaying = false;
      });
    }
  }
  Widget _buildFileButton(String filePath, int index) {
    
    return Column(
      children: [
        const SizedBox(height: 10),
        SizedBox(
          width: 200,
          height: 50,
          child: GestureDetector(
            onLongPress: () {
              _showDeleteDialog(filePath, index);
            },
            child: ElevatedButton(
              onPressed: () => _togglePlayPause(filePath),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(filePath.split('|').first),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showDeleteDialog(String filePath, int index) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eliminar archivo'),
          content:
              const Text('¿Está seguro de que desea eliminar este archivo?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                _deleteFile(index);
                Navigator.of(context).pop();
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  void _deleteFile(int index) {
    setState(() {
      _filePaths.removeAt(index);
      _saveFiles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music Player'),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.pink,
              ),
              child: Center(
                child: Text(
                  'Menú',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              title: const Text('Escoja un archivo'),
              onTap: () {
                Navigator.pop(context);
                _pickFile();
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(height: 16),
              for (int index = 0; index < _filePaths.length; index++)
                _buildFileButton(_filePaths[index], index),
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
          onPressed: _botonplay,
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

class NowPlayingScreen extends StatelessWidget {
  final String filePathWithCustomName;
  NowPlayingScreen(this.filePathWithCustomName);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(filePathWithCustomName.split('|').first),
          ],
        ),
      ),
    );
  }
}
