import 'package:equatable/equatable.dart';

import '../helpers/extension_helper.dart' show ParseDateTime;

class Task extends Equatable {
  static const idKey = 'id';
  static const titleKey = 'title';
  static const descKey = 'desc';
  static const dateKey = 'date';
  static const isCompletedKey = 'isCompleted';
  static const dateCompletedKey = 'dateCompleted';

  final int? id;
  final String title;
  final DateTime date;
  final String? description;
  final bool isCompleted;
  final DateTime? dateCompleted;

  const Task({
    this.id,
    required this.title,
    required this.date,
    this.description,
    this.isCompleted = false,
    this.dateCompleted,
  }) : assert(isCompleted ? dateCompleted != null : dateCompleted == null);

  Map<String, dynamic> toMap() {
    return {
      idKey: id,
      titleKey: title,
      // format: yyyy-MM-dd
      dateKey: date.formatToDate,
      descKey: description,
      isCompletedKey: isCompleted ? 1 : 0,
      dateCompletedKey:
          dateCompleted != null ? dateCompleted!.formatToDate : null,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map[idKey].toInt(),
      title: map[titleKey],
      date: map[dateKey],
      description: map[descKey],
      isCompleted: map[isCompletedKey],
      dateCompleted: map[dateCompletedKey],
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        date,
        description,
        isCompleted,
        dateCompleted,
      ];

  // Function() is to able to set null value
  Task copyWith({
    int? id,
    String? title,
    DateTime? date,
    String? Function()? description,
    bool? isCompleted,
    DateTime? Function()? dateCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      description: description != null ? description() : this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      dateCompleted:
          dateCompleted != null ? dateCompleted() : this.dateCompleted,
    );
  }
}
