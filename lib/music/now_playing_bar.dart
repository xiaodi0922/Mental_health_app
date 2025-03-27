import 'package:flutter/material.dart';

class NowPlayingBar extends StatelessWidget {
  final String currentSong;
  final String imagePath; // Added imagePath for the song cover
  final Duration songDuration;
  final Duration currentPosition;
  final bool isPlaying;
  final Function()? onPlayPause;
  final Function(double) onSeek;

  const NowPlayingBar({
    super.key,
    required this.currentSong,
    required this.imagePath,
    required this.songDuration,
    required this.currentPosition,
    required this.isPlaying,
    required this.onPlayPause,
    required this.onSeek,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,

      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration:  BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Row for image, title, and play/pause button
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imagePath,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  currentSong,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                icon: Icon(isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                    size: 40, color: Colors.blue),
                onPressed: onPlayPause,
              ),
            ],
          ),

          // Slider for progress
          Slider(
            min: 0,
            max: songDuration.inSeconds.toDouble(),
            value: currentPosition.inSeconds.toDouble().clamp(0, songDuration.inSeconds.toDouble()),
            onChanged: onSeek,
            activeColor: Colors.blue,
            inactiveColor: Colors.grey[300],
          ),

          // Duration times
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_formatDuration(currentPosition), style: const TextStyle(fontSize: 12)),
              Text(_formatDuration(songDuration), style: const TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(duration.inMinutes)}:${twoDigits(duration.inSeconds.remainder(60))}";
  }
}
