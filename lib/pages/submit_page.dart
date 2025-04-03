import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mental_heatlh_app/components/activity_list.dart';
import 'package:mental_heatlh_app/components/slider.dart';
import 'package:intl/intl.dart';
import '../emoji_images/mood_images.dart';

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
  Future<void> updateMoodData(DateTime selectedDate, String newMood) async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

    String userUid = FirebaseAuth.instance.currentUser!.uid;


    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('moods')
        .where('user', isEqualTo: userUid)
        .where('date', isEqualTo: Timestamp.fromDate(selectedDate)) // Use exact date comparison
        .get();

    if (snapshot.docs.isNotEmpty) {
      // Document already exists, update the mood
      String documentId = snapshot.docs[0].id;
      await FirebaseFirestore.instance
          .collection('moods')
          .doc(documentId)
          .update({
        'mood': newMood, // Update mood field with the new mood
        'activities': selectedActivities, // Update selected activities
        'stressLevel': stressLevel, // Update stress level
        'energyLevel': energyLevel, // Update energy level
        'note': writeNoteController.text, // Update the note
        'timestamp': FieldValue.serverTimestamp(),
      });
      print("Mood updated for $formattedDate");
    } else {
      // Document doesn't exist, create a new entry
      await FirebaseFirestore.instance.collection('moods').add({
        'user': userUid,
        'date': Timestamp.fromDate(selectedDate),
        'mood': newMood,
        'activities': selectedActivities,
        'stressLevel': stressLevel,
        'energyLevel': energyLevel,
        'note': writeNoteController.text,
        'timestamp': FieldValue.serverTimestamp(),
      });
      print("New mood added for $formattedDate");
    }
  }

  void _saveMoodData() async {
    if (selectedMood.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a mood')),
      );
      return;
    }

    // Call the updateMoodData function, passing the selected date and selected mood
    await updateMoodData(widget.selectedDate, selectedMood);

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Mood entry saved successfully!')),
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

              Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text("How do you feel today?",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        )
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(MoodImages.moodImages.length, (index) {
                        bool isSelected = selectedMood == MoodImages.moodImages[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedMood = MoodImages.moodImages[index];
                            });
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 75,
                                height: 95,
                                alignment: Alignment.center,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.easeOut,
                                  width: isSelected ? 75 : 45,
                                  height: isSelected ? 75 : 45,
                                  child: Image.asset(MoodImages.moodImages[index]),
                                ),
                              ),
                              Text(
                                MoodImages.moodTexts[index], // Display mood label
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
                      }),
                    ),
                  ],
                ),
              ),


              const SizedBox(height: 20),

              // Activity section
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Selection(
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
              ),

              const SizedBox(height: 20),
              //Stress level
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: MySlider(
                  title: 'Stress level',
                  value: stressLevel,
                  onChanged: (value){
                    setState(() {
                      stressLevel = value;
                    });
                  },
                  isStressSlider: true,
                ),
              ),

              const SizedBox(height: 20),
              //Energy level
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: MySlider(
                  title: 'Energy level',
                  value: energyLevel,
                  onChanged: (value){
                    setState(() {
                      energyLevel = value;
                    });
                  },
                  isStressSlider: false,
                ),
              ),

              const SizedBox(height: 20),

              //Write note
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Write a note',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      maxLines: 2,
                      controller: writeNoteController,
                      decoration: InputDecoration(
                        hintText: 'Write a note',
                        border: border,
                        enabledBorder: border,
                        focusedBorder: border1,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              //Save button
              MyButton(
                text: 'Save',
                onTap: _saveMoodData,
              ),


            ],
          ),
        ),
      ),
    );
  }
}