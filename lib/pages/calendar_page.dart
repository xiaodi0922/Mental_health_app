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
                              textMapper: (numberText) =>
                                  DateFormat.MMMM().format(DateTime(0, int.parse(numberText))),
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                      color: Colors.blue
                                  ),
                                  bottom: BorderSide(
                                      color: Colors.blue
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
                              decoration: const BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                        color: Colors.blue
                                    ),
                                    bottom: BorderSide(
                                        color: Colors.blue
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
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      color: Colors.blue, // Change color for better visibility
                    ),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          currentDate = DateTime(selectedYear, selectedMonth, 1);
                        });
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "OK",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
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
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 5),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // Weekday Labels
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
                  .map((day) => Text(
                day,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ))
                  .toList(),
            ),
          ),
          // Calendar Grid
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
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SubmitPage(selectedDate: DateTime(currentDate.year, currentDate.month, day));
                            },
                          ),
                        );
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Text(
                            '?',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text('$day', style: const TextStyle(fontSize: 16)),
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
