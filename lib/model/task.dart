import 'package:equatable/equatable.dart';

import 'package:todo_assessment/helpers/enums_helper.dart';

import '../helpers/extension_helper.dart';

class Task extends Equatable {
  static const taskTable = 'task';
  static const idKey = 'id';
  static const titleKey = 'title';
  static const descKey = 'desc';
  static const dateKey = 'date';
  static const isCompletedKey = 'isCompleted';
  static const importanceEnumKey = 'importanceEnum';
  static const indexKey = 'listIndex';

  final int? id;
  final String? title;
  final DateTime date;
  final String? description;
  final bool isCompleted;
  final ScheduleEnum scheduleEnum;
  final ImportanceEnum? importanceEnum;
  final int? index;

  Task({
    this.id,
    this.title,
    required this.date,
    this.description,
    this.isCompleted = false,
    this.importanceEnum,
    this.index,
  }) : scheduleEnum = date.getScheduleEnum;

  const Task.copyUsage({
    required this.id,
    required this.date,
    required this.description,
    required this.isCompleted,
    required this.scheduleEnum,
    required this.title,
    required this.importanceEnum,
    required this.index,
  });

  Map<String, dynamic> toMap() {
    return {
      idKey: id,
      titleKey: title,
      dateKey: date.formatToDate,
      descKey: description,
      isCompletedKey: isCompleted ? 1 : 0,
      importanceEnumKey: importanceEnum!.name,
      indexKey: index,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    final isCompleted = map[isCompletedKey] as int;
    return Task(
      id: map[idKey].toInt(),
      title: map[titleKey],
      date: (map[dateKey] as String).getDateTime,
      description: map[descKey],
      isCompleted: isCompleted == 1 ? true : false,
      importanceEnum:
          ImportanceEnum.values.byName(map[importanceEnumKey] as String),
      index: map[indexKey],
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        date,
        description,
        isCompleted,
        scheduleEnum,
        importanceEnum,
        index,
      ];

  // Function() is to able to set null value
  Task copyWith({
    int? id,
    String? title,
    DateTime? date,
    String? Function()? description,
    bool? isCompleted,
    ScheduleEnum? scheduleEnum,
    ImportanceEnum? importanceEnum,
    int? index,
  }) {
    return Task.copyUsage(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      description: description != null ? description() : this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      scheduleEnum: scheduleEnum ?? this.scheduleEnum,
      importanceEnum: importanceEnum ?? this.importanceEnum,
      index: index ?? this.index,
    );
  }

  @override
  String toString() {
    return 'Task(id: $id, title: $title, date: $date, description: $description, isCompleted: $isCompleted, scheduleEnum: $scheduleEnum, importanceEnum: $importanceEnum, index: $index)';
  }
}
