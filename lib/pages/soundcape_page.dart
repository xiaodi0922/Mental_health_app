import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../music/now_playing_bar.dart';
import '../music/song_list.dart';
import '../music/sound_tile.dart';

class SoundscapePage extends StatefulWidget {
  const SoundscapePage({super.key});

  @override
  _SoundscapePageState createState() => _SoundscapePageState();
}

class _SoundscapePageState extends State<SoundscapePage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _currentSong;
  String? _currentImage;
  Duration _songDuration = Duration.zero;
  Duration _currentPosition = Duration.zero;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _songDuration = duration;
      });
    });

    _audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        _currentPosition = position;
      });
    });

    _audioPlayer.onPlayerComplete.listen((_) {
      setState(() {
        _isPlaying = false;
        _currentPosition = Duration.zero;
      });
    });
  }

  void playSound(String songPath, String songTitle, String imagePath) async {
    if (_currentSong == songTitle && _isPlaying) {
      await _audioPlayer.pause();
      setState(() {
        _isPlaying = false;
      });
    } else {
      await _audioPlayer.play(AssetSource(songPath));
      setState(() {
        _currentSong = songTitle;
        _currentImage = imagePath;
        _isPlaying = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Soundscape",
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            _audioPlayer.stop();
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            // Song Categories and Song List
            ListView(
              children: soundCategories.entries.map((entry) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        entry.key,
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: entry.value.map((song) {
                        return SoundTile(
                          imagePath: song.imagePath,
                          title: song.title,
                          songPath: song.songPath,
                          onPlay: (path) {
                            playSound(
                                song.songPath,
                                song.title,
                                song.imagePath
                            );
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              }).toList(),
            ),
            // Floating NowPlayingBar
            if (_currentSong != null)
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: NowPlayingBar(
                  currentSong: _currentSong!,
                  imagePath: _currentImage!,
                  songDuration: _songDuration,
                  currentPosition: _currentPosition,
                  isPlaying: _isPlaying,
                  onPlayPause: () {
                    for (var category in soundCategories.values) {
                      for (var song in category) {
                        if (song.title == _currentSong) {
                          playSound(song.songPath, song.title, _currentImage!);
                          return;
                        }
                      }
                    }
                  },
                  onSeek: (value) async {
                    await _audioPlayer.seek(Duration(seconds: value.toInt()));
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
