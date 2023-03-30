import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_assessment/bloc/task/task_bloc.dart';
import 'package:todo_assessment/constants/layout_const.dart';
import 'package:todo_assessment/model/task.dart';
import 'package:todo_assessment/views/widgets/task_tile.dart';

class SliverTaskBuilder extends StatelessWidget {
  final List<Task> tasks;

  const SliverTaskBuilder({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: sidePadding,
      sliver: SliverReorderableList(
        itemCount: tasks.length,
        onReorder: (oldIndex, newIndex) {

          context.read<TaskBloc>().add(
                ReorderTaskIndexEvent(
                  oldIndex: oldIndex,
                  newIndex: newIndex,
                ),
              );
        },
        itemBuilder: (context, index) {
          return TaskTile(
            key: ValueKey(tasks[index].id),
            task: tasks[index],
            index: index,
          );
        },
      ),
    );
  }
}
