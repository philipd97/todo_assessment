import 'package:intl/intl.dart';
import 'package:todo_assessment/helpers/enums_helper.dart';
import 'package:todo_assessment/model/task.dart';

extension ParseDateTime on DateTime {
  String get formatToDate {
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(this);
  }

  String get formatToDisplableView {
    final formatter = DateFormat('dd MMMM yyyy');
    return formatter.format(this);
  }
}

extension FormatDateToString on String {
  DateTime get getDateTime {
    final splits = split('-');
    return DateTime(
      int.parse(splits.first),
      int.parse(splits[1]),
      int.parse(splits.last),
    );
  }
}

extension GetScheduleType on DateTime {
  ScheduleEnum get getScheduleEnum {
    final dateTime = DateTime.now();
    // compare on month date & year

    // Current Year > or < than date Year
    if (year > dateTime.year) {
      return ScheduleEnum.upcoming;
    } else if (year < dateTime.year) {
      return ScheduleEnum.previous;
    }

    // Current year == date year
    // Current Month > or < than date Month
    if (month > dateTime.month) {
      return ScheduleEnum.upcoming;
    } else if (month < dateTime.month) {
      return ScheduleEnum.previous;
    }

    // Current Month == date Month
    // Current Day > or < than date Day
    if (day > dateTime.day) {
      return ScheduleEnum.upcoming;
    } else if (day < dateTime.day) {
      return ScheduleEnum.previous;
    }

    return ScheduleEnum.today;
  }
}

extension Capitalize on ImportanceEnum {
  String get getString {
    switch (this) {
      case ImportanceEnum.veryImportant:
        return 'Very Important';
      case ImportanceEnum.important:
        return 'Important';
      case ImportanceEnum.partiallyImportant:
        return 'Partially Important';
    }
  }
}
