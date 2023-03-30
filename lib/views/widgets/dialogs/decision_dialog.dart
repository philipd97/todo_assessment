import 'package:flutter/material.dart';

Future<bool> decisionDialog({
  required BuildContext context,
  required String contentText,
}) async {
  return await showDialog<bool?>(
        context: context,
        builder: (context) => AlertDialog(
          elevation: 0.0,
          content: Text(
            contentText,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('No'),
            ),
          ],
        ),
      ) ??
      false;
}
