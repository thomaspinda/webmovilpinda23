import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VideoScreen(),
    );
  }
}

class VideoScreen extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool _isSecondButtonActive = false;

  @override
  void initState() {
    _controller = VideoPlayerController.asset('assets/1.mp4')
      ..addListener(() {
        if (_controller.value.position >= _controller.value.duration) {
          // El video ha terminado
          _controller.pause();
          setState(() {
            _isSecondButtonActive = true;
          });
        }
      });
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(false); // No repetir el primer video
    _controller.setVolume(1.0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _playSecondVideo() {
    // Cambia el video al segundo video cuando se presiona el segundo botón
    _controller = VideoPlayerController.asset('assets/2.mp4')
      ..addListener(() {
        if (_controller.value.position >= _controller.value.duration) {
          // El segundo video ha terminado
          _controller.pause();
          setState(() {
            _isSecondButtonActive = false;
          });
        }
      });
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(false); // No repetir el segundo video
    _controller.setVolume(1.0);
    _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(':D'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    _controller.play();
                  }
                });
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                ),
              ),
              child: Text(
                _controller.value.isPlaying ? 'HAPPY BIRTHDAY OSCAR' : 'Presione aquí',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isSecondButtonActive ? _playSecondVideo : null,
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                ),
              ),
              child: Text(
                'No presionar',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
