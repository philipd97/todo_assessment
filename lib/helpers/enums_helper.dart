import 'package:flutter/material.dart';

import 'package:todo_assessment/constants/text_const.dart';
import 'package:todo_assessment/gen/assets.gen.dart';
import 'package:todo_assessment/gen/colors.gen.dart';

abstract class ChipLayout {
  final Color textColor;
  final Color tileColor;
  final String? text;

  ChipLayout({
    required this.textColor,
    required this.tileColor,
    this.text,
  });
}

enum ScheduleEnum implements ChipLayout {
  previous(
    textColor: ColorName.previousText,
    tileColor: ColorName.previousTile,
  ),
  today(
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
  );

  @override
  final Color textColor;

  @override
  final Color tileColor;

  @override
  final String? text;

  const ScheduleEnum({
    required this.textColor,
    required this.tileColor,
    this.text,
  });
}

enum ImportanceEnum implements ChipLayout {
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

  @override
  final Color textColor;

  @override
  final Color tileColor;

  @override
  final String? text;

  const ImportanceEnum({
    required this.textColor,
    required this.tileColor,
    this.text,
  });
}

enum CalendarMonthEnum {
  january,
  february,
  march,
  april,
  may,
  june,
  july,
  august,
  september,
  october,
  november,
  december;
}

extension GetImagePath on CalendarMonthEnum {
  String get imgPath {
    const images = Assets.images;
    switch (this) {
      case CalendarMonthEnum.january:
        return images.january.path;
      case CalendarMonthEnum.february:
        return images.february.path;
      case CalendarMonthEnum.march:
        return images.march.path;
      case CalendarMonthEnum.april:
        return images.april.path;
      case CalendarMonthEnum.may:
        return images.may.path;
      case CalendarMonthEnum.june:
        return images.june.path;
      case CalendarMonthEnum.july:
        return images.july.path;
      case CalendarMonthEnum.august:
        return images.august.path;
      case CalendarMonthEnum.september:
        return images.september.path;
      case CalendarMonthEnum.october:
        return images.october.path;
      case CalendarMonthEnum.november:
        return images.november.path;
      case CalendarMonthEnum.december:
        return images.december.path;
    }
  }
}
