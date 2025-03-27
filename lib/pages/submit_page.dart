import 'package:flutter/material.dart';
import 'package:mental_heatlh_app/components/activity_list.dart';
import 'package:mental_heatlh_app/components/slider.dart';
import 'package:intl/intl.dart';

import '../components/button.dart';
import '../components/selection.dart';
import 'activity_page.dart';

class SubmitPage extends StatefulWidget {
  final DateTime selectedDate;

  const SubmitPage({
    super.key,
    required this.selectedDate,
  });

  @override
  State<SubmitPage> createState() => _SubmitPageState();
}

class _SubmitPageState extends State<SubmitPage> {
  // Stores selected mood file name
  String selectedMood = "";
  final  writeNoteController = TextEditingController();

  //selected activity
  List<String> selectedActivities = [];

  double stressLevel = 0;
  double energyLevel = 0;

  //List of moods
  final List<Map<String, String>> moods=[
    {"image": "assets/images/apple.png", "label": "Happy"},
    {"image": "assets/images/google.png", "label": "Sad"},
    {"image": "assets/images/test.png", "label": "Neutral"},
    {"image": "assets/images/image2.png", "label": "Angry"},
    {"image": "assets/images/image3.png", "label": "Loved"},

  ];
  // Function to show activity selection dialog from bottom
  void _showActivityDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return ActivityList(
          selectedActivities: selectedActivities,
          onSelected: (newActivities) {
            setState(() {
              selectedActivities = newActivities;
            });
          },
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide(
          color: Colors.blue
      ),
    );
    const border1 = OutlineInputBorder(
      borderSide: BorderSide(
          color: Colors.red
      ),
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton( // Use leading instead of placing it in title
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            DateFormat('dd-MM-yyyy').format(widget.selectedDate),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),


      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
          
              // Mood question
              Text("How do you feel today?",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  )
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: moods.map((mood) {
                  bool isSelected = selectedMood == mood["image"];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedMood = mood["image"]!;
                      });
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 75,  // Fixed width
                          height: 95, // Fixed height, prevents jump
                          alignment: Alignment.center,  // Ensures it remains centered
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 250),
                            curve: Curves.easeOut,
                            width: isSelected ? 75 : 45, // Scale only the image
                            height: isSelected ? 75 : 45,
                            child: Image.asset(mood["image"]!),
                          ),
                        ),

                        Text(
                          mood["label"]!,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: isSelected ? 16 : 14,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),




              const SizedBox(height: 20),
          
              // Activity section
              Selection(
                title: 'Activity',
                subtitle: selectedActivities.isEmpty
                    ? Text(
                  'What is your activity?',
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 16,

                  ),
                )
                    : Wrap(
                  spacing: 8, // Horizontal spacing between boxes
                  runSpacing: 8, // Vertical spacing
                  children: selectedActivities.map((activity) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.green[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        activity,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    );
                  }).toList(),
                ),
                onTap: _showActivityDialog,
              ),
          
              const SizedBox(height: 20),
              //Stress level
              MySlider(
                title: 'Stress level',
                value: stressLevel,
                onChanged: (value){
                  setState(() {
                    stressLevel = value;
                  });
                },
                isStressSlider: true,
              ),
          
              const SizedBox(height: 20),
              //Energy level
              MySlider(
                title: 'Energy level',
                value: energyLevel,
                onChanged: (value){
                  setState(() {
                    energyLevel = value;
                  });
                },
                isStressSlider: false,
              ),
          
              const SizedBox(height: 20),
          
              //Write note
              TextField(
                maxLines: 4,
                controller: writeNoteController,
                decoration: InputDecoration(
                  hintText: 'Write a note',
                  border: border,
                  enabledBorder: border,
                  focusedBorder: border1,
              ),
              ),
          
              const SizedBox(height: 30),
          
              //Save button
              MyButton(
                text: 'Save',
                onTap: (){},
              ),
          
          
            ],
          ),
        ),
      ),
    );
  }
}
