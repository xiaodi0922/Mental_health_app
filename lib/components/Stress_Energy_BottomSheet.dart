import 'dart:math';
import 'package:flutter/material.dart';

class StressEnergyBottomSheet extends StatefulWidget {
  @override
  _StressEnergyBottomSheetState createState() => _StressEnergyBottomSheetState();
}

class _StressEnergyBottomSheetState extends State<StressEnergyBottomSheet> {
  final List<String> allQuestions = [
    'Do you feel anxious?',
    'Do you feel exhausted?',
    'Do you feel unmotivated?',
    'Do you have trouble sleeping?',
    'Do you feel overwhelmed?',
    'Do you have headaches often?',
    'Do you feel sad without reason?',
    'Do you feel tense or nervous?',
    'Do you find it hard to concentrate?',
    'Do you feel like avoiding people?',
    'Do you feel emotionally drained?',
    'Do you get irritated easily?',
    'Do you feel unproductive lately?',
    'Do you feel pressure to perform?',
    'Do you lack interest in hobbies?',
  ];

  final Map<String, bool?> answers = {};
  late List<String> selectedQuestions;

  @override
  void initState() {
    super.initState();
    _selectRandomQuestions();
  }

  void _selectRandomQuestions() {
    selectedQuestions = List.from(allQuestions)..shuffle();
    selectedQuestions = selectedQuestions.take(5).toList();

    for (var q in selectedQuestions) {
      answers[q] = null; // Initialize each selected question as unanswered
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Answer the questions to calculate your stress & energy levels.',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,

            ),
          ),
          const SizedBox(height: 30),

          // Generate true/false widgets
          ...selectedQuestions.map((q) {
            return _buildTrueFalseQuestion(q);
          }).toList(),

          const SizedBox(height: 20),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(300, 60),

              backgroundColor: Theme.of(context).colorScheme.primary,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              if (answers.values.any((e) => e == null)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please answer all questions')),
                );
                return;
              }

              int stressScore = answers.values.where((e) => e == true).length;
              double stress = (stressScore / selectedQuestions.length) * 100;
              double energy = 100 - stress;

              Navigator.pop(context, {'stress': stress, 'energy': energy});
            },
            child: const Text(
                'Submit',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                )
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrueFalseQuestion(String question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            question,
            style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
            )
        ),
        Row(
          children: [
            Expanded(
              child: RadioListTile<bool>(
                title: const Text('True'),
                value: true,
                groupValue: answers[question],
                onChanged: (val) => setState(() => answers[question] = val),
              ),
            ),
            Expanded(
              child: RadioListTile<bool>(
                title: const Text('False'),
                value: false,
                groupValue: answers[question],
                onChanged: (val) => setState(() => answers[question] = val),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
