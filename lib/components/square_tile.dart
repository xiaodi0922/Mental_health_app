import 'package:flutter/material.dart';


class SquareTile extends StatelessWidget {
  final String imagePaths;

  const SquareTile({
    super.key,
    required this.imagePaths,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
        ),
          borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Image.asset(
        imagePaths,
        height: 40,
      ),



    );
  }
}
