import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color color;

  const CustomElevatedButton({
    required this.title,
    required this.onPressed,
    this.color = Colors.teal,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14),
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
