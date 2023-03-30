part of 'task_bloc.dart';

class TaskState implements Loader {
  @override
  final bool isLoading;
  final List<Task> tasks;

  const TaskState({
    required this.isLoading,
    required this.tasks,
  });

  TaskState.init()
      : isLoading = false,
        tasks = [];

  TaskState copyWith({
    bool? isLoading,
    List<Task>? tasks,
  }) {
    return TaskState(
      isLoading: isLoading ?? this.isLoading,
      tasks: tasks ?? this.tasks,
    );
  }

  @override
  String toString() {
    return 'TaskState(isLoading: $isLoading, tasks: $tasks)';
  }
}
