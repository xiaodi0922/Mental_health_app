import 'package:flutter/material.dart';

class MotivationPage extends StatefulWidget {
  @override
  _MotivationPageState createState() => _MotivationPageState();
}

class _MotivationPageState extends State<MotivationPage> {
  final List<String> _quotes = [
    "Believe in yourself and all that you are.",
    "The only way to do great work is to love what you do.",
    "Success is not final, failure is not fatal: It is the courage to continue that counts.",
    "Your limitation—it’s only your imagination.",
    "Dream it. Wish it. Do it.",
    "Don’t stop when you’re tired. Stop when you’re done.",
    "Great things never come from comfort zones."
  ];

  final Set<int> _favoriteIndexes = {}; // Store favorite quotes by index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Motivation"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),  // Back icon
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: PageView.builder(
        scrollDirection: Axis.vertical, // Scroll up/down to see next quote
        itemCount: _quotes.length,
        itemBuilder: (context, index) {
          bool isFavorite = _favoriteIndexes.contains(index);

          return Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    _quotes[index],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),


              // Favorite Icon Positioned at the Bottom
              Positioned(
                bottom: 80,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isFavorite) {
                        _favoriteIndexes.remove(index);
                      } else {
                        _favoriteIndexes.add(index);
                      }
                    });
                  },
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                    size: 40,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
