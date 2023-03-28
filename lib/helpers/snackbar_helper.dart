import 'package:flutter/material.dart';

void showCustomSnackBar({
  required BuildContext context,
  required String text,
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(text),
      duration: const Duration(milliseconds: 2500),
    ),
  );
}
