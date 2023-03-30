import 'package:flutter/material.dart';

import 'package:todo_assessment/helpers/enums_helper.dart';
import 'package:todo_assessment/helpers/sizer_helper.dart';

class CustomedChip extends StatelessWidget {
  final ChipLayout chipLayout;
  final String? label;
  final bool isCompleted;

  const CustomedChip({
    super.key,
    required this.chipLayout,
    this.label,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    final textColor =
        isCompleted ? chipLayout.textColorCompleted : chipLayout.textColor;

    final tileColor =
        isCompleted ? chipLayout.tileColorCompleted : chipLayout.tileColor;

    final text = label ?? chipLayout.text!;

    return Container(
      margin: EdgeInsets.only(right: 2.w),
      padding: EdgeInsets.symmetric(
        horizontal: 2.5.w,
        vertical: 0.75.h,
      ),
      decoration: BoxDecoration(
        color: tileColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 12.0,
        ),
      ),
    );
  }
}
