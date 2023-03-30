import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_assessment/helpers/database_helper.dart';
import 'package:todo_assessment/helpers/enums_helper.dart';
import 'package:todo_assessment/model/loader.dart';
import 'package:todo_assessment/model/task.dart';

part 'task_state.dart';
part 'task_event.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final DatabaseHelper databaseHelper;

  TaskBloc(this.databaseHelper) : super(TaskState.init()) {
    on<FetchTasksEvent>(_onFetchTaskEvents);
    on<AddTaskEvent>(_onAddTaskEvent);
    on<ReorderTaskIndexEvent>(_onReorderTaskIndexEvent);
    on<UpdateTaskEvent>(_onUpdateTaskEvent);
    on<CheckBoxTriggerEvent>(_onCheckBoxTriggerEvent);
    on<DeleteTaskEvent>(_onDeleteTaskEvent);
  }

  void _onFetchTaskEvents(
    FetchTasksEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    // fetch all tasks in db
    final db = await databaseHelper.database;
    final allTask =
        (await db.query(Task.taskTable, orderBy: '${Task.indexKey} ASC')).map(
      (taskMap) => Task.fromMap(taskMap),
    );

    emit(
      state.copyWith(
        isLoading: false,
        tasks: allTask.toList(),
      ),
    );
  }

  void _onAddTaskEvent(
    AddTaskEvent event,
    Emitter emit,
  ) async {
    final taskList = state.tasks;
    const latestIndex = 0;

    final task = Task(
      title: event.title,
      date: event.dateTime,
      importanceEnum: event.importanceEnum,
      description: event.description,
      index: latestIndex,
    );
    final db = await databaseHelper.database;
    final id = await db.insert(Task.taskTable, task.toMap());
    final taskWithId = task.copyWith(id: id);

    taskList.insert(latestIndex, taskWithId);
    // loop through & update all the task index
    if (taskList.length > 1) {
      for (int i = latestIndex + 1; i < taskList.length; i++) {
        final task = taskList[i];
        final maps = await db.query(
          Task.taskTable,
          columns: [Task.idKey, Task.indexKey],
          where: '${Task.idKey} = ?',
          whereArgs: [task.id],
        );

        if ((maps.first[Task.indexKey] as int) != i) {
          await db.update(
            Task.taskTable,
            {Task.indexKey: i},
            where: '${Task.idKey} = ?',
            whereArgs: [task.id],
          );
        }
      }
    }
    emit(state.copyWith(tasks: taskList));
  }

  void _onReorderTaskIndexEvent(
    ReorderTaskIndexEvent event,
    Emitter emit,
  ) async {
    final db = await databaseHelper.database;
    final taskList = state.tasks;

    int remove = 0;
    if (event.oldIndex > event.newIndex) {
      remove++;
    }
    final task = taskList[event.oldIndex];
    taskList.insert(event.newIndex, task);

    taskList.removeAt(event.oldIndex + remove);

    emit(state.copyWith(tasks: taskList));

    final taskGoBehind = event.newIndex > event.oldIndex;

    for (int i = taskGoBehind ? event.oldIndex : event.newIndex;
        i < taskList.length;
        i++) {
      final task = taskList[i];
      final maps = await db.query(
        Task.taskTable,
        columns: [Task.idKey, Task.indexKey],
        where: '${Task.idKey} = ?',
        whereArgs: [task.id],
      );

      if ((maps.first[Task.indexKey] as int) != i) {
        await db.update(
          Task.taskTable,
          {Task.indexKey: i},
          where: '${Task.idKey} = ?',
          whereArgs: [task.id],
        );
      }
    }
  }

  void _onUpdateTaskEvent(UpdateTaskEvent event, Emitter emit) async {
    final taskIndex = state.tasks.indexWhere((task) => task.id == event.taskId);
    final db = await databaseHelper.database;
    final list = state.tasks;

    final task = list[taskIndex].copyWith(
      importanceEnum: event.importanceEnum,
      date: event.dateTime,
      title: event.title,
      description: event.description == null ? null : () => event.description,
    );
    await db.update(
      Task.taskTable,
      task.toMap(),
      where: '${Task.idKey} = ?',
      whereArgs: [task.id],
    );

    list[taskIndex] = task;
    emit(state.copyWith(tasks: list));
  }

  void _onCheckBoxTriggerEvent(CheckBoxTriggerEvent event, Emitter emit) async {
    final taskIndex = state.tasks.indexWhere((task) => task.id == event.taskId);
    final db = await databaseHelper.database;
    final list = state.tasks;


    final task = list[taskIndex];

    final newTaskCopy = task.copyWith(isCompleted: event.isCompleted);

    final result = await db.update(
      Task.taskTable,
      newTaskCopy.toMap(),
      where: '${Task.idKey} = ?',
      whereArgs: [task.id],
    );

    list[taskIndex] = newTaskCopy;
    emit(state.copyWith(tasks: list));
  }

  void _onDeleteTaskEvent(DeleteTaskEvent event, Emitter emit) async {
    final taskIndex = state.tasks.indexWhere((task) => task.id == event.taskId);
    final db = await databaseHelper.database;

    final list = state.tasks;
    final task = list[taskIndex];
    list.removeAt(taskIndex);

    await db.delete(
      Task.taskTable,
      where: '${Task.idKey} = ?',
      whereArgs: [task.id],
    );

    emit(state.copyWith(tasks: list));
  }
}
