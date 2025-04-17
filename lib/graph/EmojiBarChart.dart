
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class EmojiBarChart extends StatelessWidget {
  final Map<String, int> moodCounts;
  const EmojiBarChart({
    super.key,
    required this.moodCounts,
  });

  static final Map<String, Color> moodColors =  {
    "assets/images/Awful.png": const Color.fromARGB(255, 255, 36, 0),
    "assets/images/Sad.png": const Color.fromARGB(255, 255, 143, 0),
    "assets/images/Neutral.png": const Color.fromARGB(255, 255, 200, 42),
    "assets/images/Good.png": const Color.fromARGB(255, 111, 176, 69),
    "assets/images/Great.png": const Color.fromARGB(255, 70, 175, 80),
  };


  Widget build(BuildContext context) {
    final moods = moodCounts.keys.toList();
    final values = moodCounts.values.toList();
    final maxValue = values.isNotEmpty ? values.reduce((a, b) {
      return a > b ? a : b;
    }) : 1;

    return AspectRatio(
      aspectRatio: 1.3,
      child: BarChart(
        BarChartData(
          maxY: maxValue.toDouble() + 1,
          barTouchData: BarTouchData(enabled: true),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 60,
                getTitlesWidget: (double value, TitleMeta meta) {
                 int index = value.toInt();
                 if (index < moods.length){
                   return Padding(
                     padding:const EdgeInsets.only(top: 8.0),
                     child: Image.asset(
                        moods[index],
                        width: 30,
                        height: 30,
                     ),
                   );
                 } else {
                    return const SizedBox.shrink();
                 }
                },
              ),
            ),
          ),
          gridData: FlGridData(show : false),
          borderData: FlBorderData(show: true),
          barGroups: List.generate(moods.length, (index){
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: values[index].toDouble(),
                  color: moodColors[moods[index]],
                  width: 20,
                  borderRadius: BorderRadius.circular(8),
                ),
              ],
            );
          })

        )
      ),



    );
  }
}
