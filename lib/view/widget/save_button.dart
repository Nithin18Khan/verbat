import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SaveButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFF9800), // Orange color for the button
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Rounded corners
        ),
        padding: const EdgeInsets.symmetric(horizontal: 89, vertical: 16),
      ),
      child: const Text(
        'Save',
        style: TextStyle(
          color: Colors.white, // White text color
          fontWeight: FontWeight.bold, // Bold font weight
          fontSize: 16, // Font size
        ),
      ),
    );
  }
}
