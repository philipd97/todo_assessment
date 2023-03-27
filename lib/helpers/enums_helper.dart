import 'package:flutter/material.dart';
import 'package:todo_assessment/constants/text_const.dart';
import 'package:todo_assessment/gen/colors.gen.dart';

enum ChipType {
  todayIncompleteTile(
    textColor: Colors.black,
    tileColor: ColorName.todayIncompleteTile,
    text: TextConst.today,
  ),
  todayCompleted(
    textColor: ColorName.todayCompletedText,
    tileColor: ColorName.todayCompletedTile,
    text: TextConst.today,
  ),
  upcoming(
    textColor: ColorName.upcomingText,
    tileColor: ColorName.upcomingTile,
    text: TextConst.upcoming,
  ),
  veryImportant(
    textColor: ColorName.veryImportantText,
    tileColor: ColorName.veryImportantTile,
    text: TextConst.veryImportant,
  ),
  important(
    textColor: ColorName.importantText,
    tileColor: ColorName.importantTile,
    text: TextConst.important,
  ),
  partiallyImportant(
    textColor: ColorName.partiallyImportantText,
    tileColor: ColorName.partiallyImportantTile,
    text: TextConst.partImportant,
  );

  final Color textColor;
  final Color tileColor;
  final String? text;

  const ChipType({
    required this.textColor,
    required this.tileColor,
    this.text,
  });
}
