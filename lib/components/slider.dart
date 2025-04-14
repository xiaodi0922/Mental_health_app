import 'package:flutter/material.dart';

class MySlider extends StatelessWidget {
  final String title;
  final double value;
  final ValueChanged<double> onChanged;
  final bool isStressSlider;
  const MySlider({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    required this.isStressSlider,
  });

  Color _getActiveColor(double value) {
    const customGreen = Color.fromRGBO(111, 176, 69, 1);
    if (isStressSlider) {
      // Stress level: Green (0) to Yellow (50) to Red (100)
      if (value <= 50) {
        // Blend between green and yellow
        return Color.lerp(
          customGreen,
          Colors.yellow,
          value / 50,
        )!;
      } else {
        // Blend between yellow and red
        return Color.lerp(
          Colors.yellow,
          Colors.red,
          (value - 50) / 50,
        )!;
      }
    } else {
      // Energy level: Red (0) to Yellow (50) to Green (100)
      if (value <= 50) {
        // Blend between red and yellow
        return Color.lerp(
          Colors.red,
          Colors.yellow,
          value / 50,
        )!;
      } else {
        // Blend between yellow and green
        return Color.lerp(
          Colors.yellow,
          customGreen,
          (value - 50) / 50,
        )!;
      }
    }
  }

  // Helper method to determine text color based on background color
  Color _getContrastColor(Color backgroundColor) {
    // Calculate luminance - a value between 0 (black) and 1 (white)
    double luminance = (0.299 * backgroundColor.red +
        0.587 * backgroundColor.green +
        0.114 * backgroundColor.blue) / 255;

    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    final currentColor = _getActiveColor(value);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          )
        ),
        SizedBox(height: 8),
        // Slider with label on right side
        Row(
          children: [
            // Slider taking most of the space
            Expanded(
              flex: 85,
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: currentColor,
                  thumbColor: currentColor,
                  overlayColor: currentColor.withOpacity(0.3),
                ),
                child: Slider(
                  value: value,
                  min: 0,
                  max: 100,
                  divisions: 100,
                  onChanged: onChanged,
                ),
              ),
            ),
            // Colored value label on right side
            Expanded(
              flex: 15,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: currentColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  value.round().toString(),
                  style: TextStyle(
                    color: _getContrastColor(currentColor),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
