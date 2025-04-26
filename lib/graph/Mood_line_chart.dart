import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MoodLineChart extends StatelessWidget {
  final Map<DateTime, double> moodTrend;

  const MoodLineChart({super.key, required this.moodTrend});

  @override
  Widget build(BuildContext context) {
    Color getColorForMood(double mood) {
      switch (mood.round()) {
        case 1:
          return const Color.fromARGB(255, 255, 36, 0);
        case 2:
          return const Color.fromARGB(255, 255, 143, 0);
        case 3:
          return const Color.fromARGB(255, 255, 200, 42);
        case 4:
          return const Color.fromARGB(255, 111, 176, 69);
        case 5:
          return const Color.fromARGB(255, 70, 175, 80);
        default:
          return Colors.grey;
      }
    }

    List<DateTime> sortedDates = moodTrend.keys.toList()..sort();

    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: (sortedDates.length - 1).toDouble(),
          minY: 1,
          maxY: 5,
          clipData: FlClipData.all(),
          titlesData: FlTitlesData(
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false), // Hide top titles
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false), // Hide right titles
            ),

            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  String imageAsset;
                  if (value == 1) {
                    imageAsset = 'assets/images/Awful.png';
                  } else if (value == 2) {
                    imageAsset = 'assets/images/Sad.png';
                  } else if (value == 3) {
                    imageAsset = 'assets/images/Neutral.png';
                  } else if (value == 4) {
                    imageAsset = 'assets/images/Good.png';
                  } else if (value == 5) {
                    imageAsset = 'assets/images/Great.png';
                  } else {
                    imageAsset = 'assets/images/Neutral.png';
                  }

                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Image.asset(imageAsset, height: 20),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value % 2 != 0) return const SizedBox.shrink();
                  final index = value.toInt();
                  if (index < sortedDates.length) {
                    final date = sortedDates[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        DateFormat('d/M').format(date),
                        style: const TextStyle(
                          fontSize: 12,
                        fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                  return const Text('');
                },
              ),
            ),
          ),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(
            show: true,
          ),
          lineBarsData: [
            LineChartBarData(
              spots: sortedDates.asMap().entries.map((entry) {
                final index = entry.key;
                final date = entry.value;
                return FlSpot(index.toDouble(), moodTrend[date]!);
              }).toList(),
              isCurved: true,
              gradient: LinearGradient(
                colors: sortedDates.map((date) {
                  final mood = moodTrend[date]!;
                  return getColorForMood(mood);
                }).toList(),
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              dotData: FlDotData(show: true),
              belowBarData: BarAreaData(show: false),
              barWidth: 3,
            ),
          ],

        ),
      ),
    );
  }
}


