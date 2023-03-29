import 'package:flutter/material.dart';
import 'package:todo_assessment/constants/text_const.dart';

import 'package:todo_assessment/gen/colors.gen.dart';
import 'package:todo_assessment/helpers/enums_helper.dart';
import 'package:todo_assessment/helpers/sizer_helper.dart';

class CustomedChip extends StatelessWidget {
  final ChipLayout chipLayout;
  final String? label;

  const CustomedChip({
    super.key,
    required this.chipLayout,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = chipLayout.textColor;
    final tileColor = chipLayout.tileColor;
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
