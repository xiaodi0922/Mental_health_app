import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mental_heatlh_app/graph/Mood_Bar.dart';
import 'package:numberpicker/numberpicker.dart';
import '../graph/EmojiBarChart.dart';
import 'package:intl/intl.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final user = FirebaseAuth.instance.currentUser;
  DateTime selectedMonth = DateTime.now();

  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
  }

  // Generate the first day of each month for the past 12 months
  List<DateTime> getLast12Months() {
    DateTime now = DateTime.now();
    return List.generate(12, (index) {
      return DateTime(now.year, now.month - index, 1);
    }).reversed.toList(); // ascending order
  }

  // Stream that fetches mood count data from Firestore for selected month
  Stream<Map<String, int>> moodCountStream() {
    DateTime startOfMonth = DateTime(selectedMonth.year, selectedMonth.month, 1);
    DateTime endOfMonth = DateTime(selectedMonth.year, selectedMonth.month + 1, 0);

    return FirebaseFirestore.instance
        .collection('moods')
        .where('user', isEqualTo: user!.uid)
        .where('date', isGreaterThanOrEqualTo: startOfMonth)
        .where('date', isLessThanOrEqualTo: endOfMonth)
        .snapshots()
        .map((snapshot) {
      Map<String, int> tempCounts = {
        "assets/images/Awful.png": 0,
        "assets/images/Sad.png": 0,
        "assets/images/Neutral.png": 0,
        "assets/images/Good.png": 0,
        "assets/images/Great.png": 0,
      };

      for (var doc in snapshot.docs) {
        var data = doc.data();
        String mood = data['mood'];
        if (tempCounts.containsKey(mood)) {
          tempCounts[mood] = tempCounts[mood]! + 1;
        }
      }

      return tempCounts;
    });
  }
// Default to current month

  void _showMonthYearPicker() {
    int selectedYear = selectedMonth.year;
    int selectedMonthValue = selectedMonth.month;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Select Month & Year",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          content: SizedBox(
            width: 300,
            height: 180,
            child: StatefulBuilder(
              builder: (context, setDialogState) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const Text("Month"),
                        const SizedBox(height: 10),
                        NumberPicker(
                          selectedTextStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          itemWidth: 120,
                          value: selectedMonthValue,
                          minValue: 1,
                          maxValue: 12,
                          infiniteLoop: true,
                          onChanged: (value) {
                            setDialogState(() {
                              selectedMonthValue = value;
                            });
                          },
                          textMapper: (numberText) {
                            return DateFormat.MMMM().format(DateTime(0, int.parse(numberText)));
                          },
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(color: Theme.of(context).colorScheme.primary),
                              bottom: BorderSide(color: Theme.of(context).colorScheme.primary),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 30),
                    Column(
                      children: [
                        const Text("Year"),
                        const SizedBox(height: 10),
                        NumberPicker(
                          selectedTextStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          value: selectedYear,
                          minValue: 2000,
                          maxValue: 2050,
                          onChanged: (value) {
                            setDialogState(() {
                              selectedYear = value;
                            });
                          },
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(color: Theme.of(context).colorScheme.primary),
                              bottom: BorderSide(color: Theme.of(context).colorScheme.primary),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade300,
                    ),
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Container(
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          selectedMonth = DateTime(selectedYear, selectedMonthValue, 1);
                        // You can call your report fetching method here
                        });
                        Navigator.pop(context);
                      },
                      child: const Text("OK", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    List<DateTime> availableMonths = getLast12Months();

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: _showMonthYearPicker,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormat('MMMM yyyy').format(selectedMonth),
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 5),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // User Info
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.black45,
                    child: Icon(Icons.person, size: 30, color: Colors.white),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    user?.email ?? 'No user',
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ],
              ),
            ),

            // Bar Chart
            StreamBuilder<Map<String, int>>(
              stream: moodCountStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError) {
                  return const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('Error loading mood data'),
                  );
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('No mood data available'),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        EmojiBarChart(moodCounts: snapshot.data!),
                        const SizedBox(height: 30),
                        MoodBar(moodCounts: snapshot.data!), // Mood bar below chart
                      ],
                    ),
                  );

                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
