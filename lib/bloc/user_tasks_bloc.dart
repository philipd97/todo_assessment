import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_assessment/model/task.dart';

abstract class UserTaskEvent extends Equatable {
  const UserTaskEvent();
}

class InputNameEvent extends UserTaskEvent {
  final String username;

  const InputNameEvent({required this.username});

  @override
  List<Object> get props => [username];
}

class UserTaskBloc extends Bloc<UserTaskEvent, String?> {
  UserTaskBloc() : super(null) {
    on<InputNameEvent>((event, emit) async {
      // await Future.delayed(const Duration(seconds: 2));
      // emit(null);
      // log('state: $state');
      // await Future.delayed(const Duration(seconds: 2));
      // emit('gotname');
      // log('state: $state');
      // await Future.delayed(const Duration(seconds: 2));
      // emit('another name');
      // log('state: $state');
    });
  }
}

// class TaskState {
//   final List<Task> prevTask;
//   final List<Task> todayTask;
//   final List<Task> upcomingTask;

//   TaskState({
//     required this.prevTask,
//     required this.todayTask,
//     required this.upcomingTask,
//   });

//   TaskState.init()
//       : prevTask = [],
//         todayTask = [],
//         upcomingTask = [];

//   TaskState copyWith({
//     String? username,
//     bool? isLoading,
//     List<Task>? prevTask,
//     List<Task>? todayTask,
//     List<Task>? upcomingTask,
//   }) {
//     return TaskState(
//       username: username ?? this.username,
//       isLoading: isLoading ?? this.isLoading,
//       prevTask: prevTask ?? this.prevTask,
//       todayTask: todayTask ?? this.todayTask,
//       upcomingTask: upcomingTask ?? this.upcomingTask,
//     );
//   }
// }
