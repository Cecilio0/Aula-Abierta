import 'package:flutter/material.dart';

class WinDialog extends StatelessWidget {
  String description;

  WinDialog({
    super.key,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("¡Ganaste!"),
      content: Text(description),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close popup
            Navigator.of(context).pop(); // Go back to last page
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.deepPurple.shade600,
          ),
          child: const Text(
            'Ok',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
        ),
      ],
    );
  }
}