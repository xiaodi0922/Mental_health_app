import 'package:flutter/material.dart';

class ActivityList extends StatefulWidget {
  final List<String> selectedActivities;
  final Function(List<String>) onSelected;

  const ActivityList({
    super.key,
    required this.selectedActivities,
    required this.onSelected,
  });

  @override
  State<ActivityList> createState() => _ActivityListState();
}

class _ActivityListState extends State<ActivityList> {
  final List<String> activities = [
    "Exercise", "Reading", "Gaming", "Meditation", "Watching TV",
    "Cooking", "Walking", "Shopping", "Listening to Music", "Drawing"
  ];

  late List<String> tempSelectedActivities;
  final TextEditingController _customActivityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tempSelectedActivities = List.from(widget.selectedActivities);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: 500,
      child: Column(
        children: [
          Text(
            "Select Activities",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),

          // Custom activity input
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _customActivityController,
                  decoration: InputDecoration(
                    hintText: "Add custom activity",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  ),
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  final customActivity = _customActivityController.text.trim();
                  if (customActivity.isNotEmpty &&
                      !activities.contains(customActivity)) {
                    setState(() {
                      activities.add(customActivity);
                      tempSelectedActivities.add(customActivity);
                      _customActivityController.clear();
                    });
                  }
                },
                child: Icon(Icons.add),
              ),
            ],
          ),

          SizedBox(height: 15),

          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2,
              ),
              itemCount: activities.length,
              itemBuilder: (context, index) {
                final activity = activities[index];
                final isSelected = tempSelectedActivities.contains(activity);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        tempSelectedActivities.remove(activity);
                      } else {
                        tempSelectedActivities.add(activity);
                      }
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey[200],
                      border: Border.all(
                        color: isSelected ? Colors.green : Colors.grey,
                        width: isSelected ? 3 : 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      activity,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black),
            ),
            onPressed: () {
              widget.onSelected(tempSelectedActivities);
              Navigator.pop(context);
            },
            child: Text(
              "Save",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
