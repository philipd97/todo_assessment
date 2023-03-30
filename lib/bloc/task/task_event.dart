part of 'task_bloc.dart';

abstract class TaskEvent {
  const TaskEvent();
}

class FetchTasksEvent extends TaskEvent {
  const FetchTasksEvent();
}

class AddTaskEvent extends TaskEvent {
  final String title;
  final String? description;
  final DateTime dateTime;
  final ImportanceEnum importanceEnum;

  const AddTaskEvent({
    required this.title,
    required this.description,
    required this.dateTime,
    required this.importanceEnum,
  });

  @override
  String toString() {
    return 'AddTaskEvent(title: $title, description: $description, dateTime: $dateTime, importanceEnum: $importanceEnum)';
  }
}

class ReorderTaskIndexEvent extends TaskEvent {
  final int oldIndex;
  final int newIndex;

  const ReorderTaskIndexEvent({
    required this.oldIndex,
    required this.newIndex,
  });
}

class UpdateTaskEvent extends TaskEvent {
  final int taskId;
  final String title;
  final String? description;
  final DateTime dateTime;
  final ImportanceEnum importanceEnum;

  const UpdateTaskEvent({
    required this.taskId,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.importanceEnum,
  });

  @override
  String toString() {
    return 'UpdateTaskEvent(taskId: $taskId, title: $title, description: $description, dateTime: $dateTime, importanceEnum: $importanceEnum)';
  }
}

class CheckBoxTriggerEvent extends TaskEvent {
  final int taskId;
  final bool isCompleted;

  const CheckBoxTriggerEvent({
    required this.taskId,
    required this.isCompleted,
  });
}

class DeleteTaskEvent extends TaskEvent {
  final int taskId;

  const DeleteTaskEvent({
    required this.taskId,
  });
}
