import 'package:flutter/material.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showDialog(
    context: context,
    builder: (aty) {
      return AlertDialog(
        title: const Text(
          'An error occurred',
          style: TextStyle(
            color: Colors.red,
          ),
        ),
        content: Text(text),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(aty).pop();
            },
            child: const Text('OK'),
          )
        ],
      );
    },
  );
}
