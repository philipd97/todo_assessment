import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_assessment/bloc/task/task_bloc.dart';
import 'package:todo_assessment/helpers/enums_helper.dart';
import 'package:todo_assessment/helpers/extension_helper.dart';
import 'package:todo_assessment/helpers/sizer_helper.dart';
import 'package:todo_assessment/model/task.dart';
import 'package:todo_assessment/views/pages/task_detail_page.dart';
import 'package:todo_assessment/views/widgets/customed_chip.dart';
import 'package:todo_assessment/views/widgets/tile_checkbox.dart';

class TaskTile extends StatelessWidget {
  final int index;
  final Task task;

  const TaskTile({super.key, required this.task, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0.0, 3.0),
            blurRadius: 2.0,
            spreadRadius: 0.5,
          ),
          BoxShadow(
            offset: const Offset(0.0, -2.0),
            blurRadius: 1.0,
            color: Colors.black.withOpacity(0.025),
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(
        vertical: 0.75.h,
        horizontal: 1.w,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(
            // Default horizontal = 16.0
            horizontal: 16.0,
            vertical: 0.6.h,
          ),
          onTap: () {
            context.push(
              TaskDetailPage.routeName,
              extra: {'task': task},
            );
          },
          leading: TileCheckbox(
            isCompleted: task.isCompleted,
            onChanged: (onChanged) => context.read<TaskBloc>().add(
                  CheckBoxTriggerEvent(
                    taskId: task.id!,
                    isCompleted: onChanged,
                  ),
                ),
          ),
          title: Text(task.title),
          subtitle: Row(
            children: [
              CustomedChip(
                chipLayout: task.scheduleEnum,
                isCompleted: task.isCompleted,
                label: task.scheduleEnum != ScheduleEnum.today
                    ? task.date.formatToDisplableView
                    : null,
              ),
              CustomedChip(chipLayout: task.importanceEnum),
            ],
          ),
          trailing: ReorderableDragStartListener(
            index: index,
            child: const Icon(Icons.drag_handle),
          ),
        ),
      ),
    );
  }
}
