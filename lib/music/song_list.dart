class SongItem {
  final String title;
  final String songPath;
  final String imagePath; // Add imagePath field

  SongItem({required this.title, required this.songPath, required this.imagePath});
}


final Map<String, List<SongItem>> soundCategories = {
  "Lofi": [
    SongItem(
      title: "Chill Vibes",
      songPath: "audio/lofi.mp3",
      imagePath: "assets/images/test.png",
    ),
    SongItem(
      title: "Rainy Night",
      songPath: "audio/lofi.mp3",
      imagePath: "assets/images/test.png",
    ),
  ],
  "Meditation": [
    SongItem(
      title: "Deep Focus",
      songPath: "audio/meditation.mp3",
      imagePath: "assets/images/test.png",
    ),
    SongItem(
      title: "Inner Peace",
      songPath: "audio/meditation2.mp3",
      imagePath: "assets/images/test.png",
    ),
    SongItem(
      title: "Inner Peace",
      songPath: "audio/meditation2.mp3",
      imagePath: "assets/images/test.png",
    ),
    SongItem(
      title: "Inner Peace",
      songPath: "audio/meditation2.mp3",
      imagePath: "assets/images/test.png",
    ),
    SongItem(
      title: "Inner Peace",
      songPath: "audio/meditation2.mp3",
      imagePath: "assets/images/test.png",
    ),
  ],
  "Sleep": [
    SongItem(
      title: "Soft Piano",
      songPath: "audio/sleep1.mp3",
      imagePath: "assets/images/test.png",
    ),
    SongItem(
      title: "Gentle Waves",
      songPath: "audio/sleep2.mp3",
      imagePath: "assets/images/test.png",
    ),
    SongItem(
      title: "Gentle Waves",
      songPath: "audio/sleep2.mp3",
      imagePath: "assets/images/test.png",
    ),
    SongItem(
      title: "Gentle Waves",
      songPath: "audio/sleep2.mp3",
      imagePath: "assets/images/test.png",
    ),
    SongItem(
      title: "Gentle Waves",
      songPath: "audio/sleep2.mp3",
      imagePath: "assets/images/test.png",
    ),
  ],
};
