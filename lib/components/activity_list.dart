import 'package:flutter/material.dart';
import 'package:mental_heatlh_app/components/button.dart';

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
  // List of activities
  final List<String> activities = [
    "Exercise", "Reading", "Gaming", "Meditation", "Watching TV",
    "Cooking", "Walking", "Shopping", "Listening to Music", "Drawing"
  ];
  late List<String> tempSelectedActivities;

  @override
  void initState() {
    super.initState();
    tempSelectedActivities = List.from(widget.selectedActivities);
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding:  EdgeInsets.all(20),
      height: 400,
      child: Column(
        children: [
          Text("Select Activities",
              style: TextStyle(
                  fontSize: 20,
                fontWeight: FontWeight.bold,
                 )),

          SizedBox(height: 10),

          Expanded(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,//3 item per row
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2,// box height
                ),
              itemCount: activities.length,
              itemBuilder: (context, index) {
                  final activity = activities[index];
                  final isSelected = tempSelectedActivities.contains(activity);
                  return GestureDetector(
                    onTap: (){
                      setState(() {
                        if(isSelected){
                          tempSelectedActivities.remove(activity);
                        } else {
                          tempSelectedActivities.add(activity);
                        }
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.green[300] : Colors.grey[200],
                        border: Border.all(
                        color: isSelected ? Colors.green : Colors.grey,
                        width: isSelected ? 3 : 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        activity,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,

                        ),
                      ),
                    ),
                  );
              },),

          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black),
            ),
            onPressed: () {
              widget.onSelected(tempSelectedActivities);
              Navigator.pop(context);
            },
            child: Text("Save",
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
