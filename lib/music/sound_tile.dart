import 'package:flutter/material.dart';

class SoundTile extends StatelessWidget {
  final String title;
  final String songPath;
  final String imagePath; // Add imagePath
  final Function(String) onPlay;

  const SoundTile({
    super.key,
    required this.title,
    required this.songPath,
    required this.imagePath,
    required this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPlay(songPath);
      }, // Play song when the container is tapped
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Theme.of(context).colorScheme.primary),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color:
              Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2)
              )
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  imagePath, // Use the imagePath from SongItem
                  width: 50, // Adjust the image size
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
