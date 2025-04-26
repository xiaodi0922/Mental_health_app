import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class StressEnergyIndicator extends StatelessWidget {
  final String title;
  final double percentage; // from 0 to 100
  final Color progressColor;

  const StressEnergyIndicator({
    Key? key,
    required this.title,
    required this.percentage,
    required this.progressColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 60.0,
      lineWidth: 13.0,
      animation: true,
      percent: (percentage.clamp(0, 100)) / 100,
      center: Text(
        "${percentage.toStringAsFixed(0)}%",
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      footer: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text(title,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
            )
        ),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: progressColor,
      backgroundColor: Colors.grey.shade300,
    );
  }
}
