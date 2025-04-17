import 'package:flutter/material.dart';

class StressEnergyDialog extends StatefulWidget {
  @override
  _StressEnergyDialogState createState() => _StressEnergyDialogState();
}

class _StressEnergyDialogState extends State<StressEnergyDialog> {
  int q1 = 0;
  int q2 = 0;
  int q3 = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Answer to predict Stress & Energy'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildQuestion('How tired do you feel?', (val) => setState(() => q1 = val)),
          _buildQuestion('How anxious do you feel?', (val) => setState(() => q2 = val)),
          _buildQuestion('How motivated do you feel?', (val) => setState(() => q3 = val)),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            int rawStress = q1 + q2 + (4 - q3); // higher q3 = less stress
            double stress = (rawStress / 12) * 100;
            Navigator.of(context).pop({'stress': stress.clamp(0, 100)});
          },
          child: Text('Submit'),
        ),
      ],
    );
  }

  Widget _buildQuestion(String text, Function(int) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text),
        DropdownButton<int>(
          value: 0,
          items: List.generate(5, (index) => DropdownMenuItem(value: index, child: Text('$index'))),
          onChanged: (val) => onChanged(val!),
        ),
      ],
    );
  }
}
