import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mental_heatlh_app/pages/submit_page.dart';
import 'package:numberpicker/numberpicker.dart';


class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime currentDate = DateTime.now();
  Map<String, String> moodData = {};

  @override
  void initState() {
    super.initState();
    fetchMoodData();
  }

  Future<void> fetchMoodData() async {
    String startOfMonth = DateFormat('yyyy-MM-01').format(currentDate);
    String endOfMonth = DateFormat('yyyy-MM-dd').format(DateTime(currentDate.year, currentDate.month + 1, 0));


    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('moods')
        .where('user', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('date', isGreaterThanOrEqualTo: DateTime.parse(startOfMonth))
        .where('date', isLessThanOrEqualTo: DateTime.parse(endOfMonth))
        .get();

    Map<String, String> tempMoodData = {};

    for (var doc in snapshot.docs) {
      var data = doc.data() as Map<String, dynamic>;
      DateTime date = (data['date'] as Timestamp).toDate();
      String formattedDate = DateFormat('yyyy-MM-dd').format(date);

      tempMoodData[formattedDate] = data['mood']; // Save mood emoji path
    }

    setState(() {
      moodData = tempMoodData;
    });
  }

  void _showMonthYearPicker() {
    int selectedYear = currentDate.year;
    int selectedMonth = currentDate.month;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Select Month & Year",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          content: SizedBox(
            width: 300,  // Adjust the width
            height: 180,

            child: StatefulBuilder(
              builder: (context, setDialogState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            const Text("Month"),
                            const SizedBox(height: 10),
                            NumberPicker(
                              selectedTextStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              itemWidth: 120,
                              value: selectedMonth,
                              minValue: 1,
                              maxValue: 12,
                              infiniteLoop: true,
                              onChanged: (value) {
                                setDialogState(() {
                                  selectedMonth = value;
                                });
                              },
                              textMapper: (numberText) {
                                return DateFormat.MMMM().format(DateTime(0, int.parse(numberText)));
                              },
                              decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                        color: Theme.of(context).colorScheme.primary
                                    ),
                                    bottom: BorderSide(
                                        color: Theme.of(context).colorScheme.primary
                                    ),
                                  )
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 30),
                        // Year Picker
                        Column(
                          children: [
                            const Text("Year"),
                            const SizedBox(height: 10),
                            NumberPicker(
                              selectedTextStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              value: selectedYear,
                              minValue: 2000,
                              maxValue: 2050,
                              onChanged: (value) {
                                setDialogState(() {
                                  selectedYear = value;
                                });
                              },
                              decoration:  BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                        color: Theme.of(context).colorScheme.primary
                                    ),
                                    bottom: BorderSide(
                                        color: Theme.of(context).colorScheme.primary
                                    ),
                                  )
                              ),
                            ),
                          ],
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
              mainAxisAlignment: MainAxisAlignment.center, // Center the buttons
              children: [
                Expanded(
                  child: Container(
                    height: 55, // Increased button height
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade300,
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20), // Space between buttons
                Expanded(
                  child: Container(
                    height: 55, // Increased button height
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.primary, // Change color for better visibility
                    ),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          currentDate = DateTime(selectedYear, selectedMonth, 1);
                          fetchMoodData();
                        });
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "OK",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
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
    int daysInMonth = DateTime(currentDate.year, currentDate.month + 1, 0).day;
    int startDay = DateTime(currentDate.year, currentDate.month, 1).weekday % 7;

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: _showMonthYearPicker,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormat('MMMM yyyy').format(currentDate),
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight:
                    FontWeight.bold),
              ),
              const SizedBox(width: 5),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
                  .map((day) {
                    return Text(
                day,
                style: const TextStyle(
                    fontWeight:
                    FontWeight.bold,
                    fontSize: 16),
              );
                  })
                  .toList(),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 0.65,
              ),
              itemCount: daysInMonth + startDay,
              itemBuilder: (context, index) {
                if (index < startDay) {
                  return const SizedBox.shrink();
                }
                int day = index - startDay + 1;
                String formattedDate = DateFormat('yyyy-MM-dd').format(
                    DateTime(currentDate.year, currentDate.month, day));
                String? emojiPath = moodData[formattedDate];
                DateTime selectedDate = DateTime(currentDate.year, currentDate.month, day);
                bool isFuture = selectedDate.isAfter(DateTime.now());

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: isFuture ? null : () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SubmitPage(selectedDate: selectedDate);
                            },
                          ),
                        );
                        fetchMoodData();
                      },
                      child: Opacity(
                        opacity: isFuture ? 0.3 : 1.0,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            shape: BoxShape.circle,
                            border: selectedDate.year == DateTime.now().year &&
                                selectedDate.month == DateTime.now().month &&
                                selectedDate.day == DateTime.now().day
                                ? Border.all(
                              color: Theme.of(context).colorScheme.primary,
                              width: 3,
                            )
                                : null,
                          ),
                          child: Center(
                            child: emojiPath != null
                                ? Image.asset(
                                emojiPath,
                                width: 50,
                                height: 50,
                            )
                                : const SizedBox(),
                          ),
                        ),
                      ),

                    ),
                    const SizedBox(height: 5),
                    Text('$day',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        )
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
