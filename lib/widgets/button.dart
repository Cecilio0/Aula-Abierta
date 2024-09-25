import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double fontSize;
  final Color textColor;
  final Size size;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.fontSize = 22,
    this.textColor = Colors.black,
    this.size = const Size(250, 30),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed, // Pass the onPressed callback
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple.shade600,
        fixedSize: size,
        // shape: BeveledRectangleBorder()
      ),
      child: Text(
        text,
        style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
            color: Colors.white
        ),
      ),
    );
  }
}
