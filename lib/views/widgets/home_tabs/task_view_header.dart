import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_assessment/bloc/task/task_bloc.dart';
import 'package:todo_assessment/bloc/user/user_bloc.dart';
import 'package:todo_assessment/constants/layout_const.dart';
import 'package:todo_assessment/helpers/enums_helper.dart';
import 'package:todo_assessment/helpers/extension_helper.dart';
import 'package:todo_assessment/helpers/sizer_helper.dart';
import 'package:todo_assessment/views/widgets/customed_chip.dart';

class TaskViewHeader extends StatelessWidget {
  const TaskViewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: sidePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top + 2.h),
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              return Text(
                'Welcome, ${state.username}!',
                maxLines: 1,
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CustomedChip(
                        chipLayout: ScheduleEnum.today,
                      ),
                      BlocBuilder<TaskBloc, TaskState>(
                        builder: (context, state) {
                          final task = state.tasks;
                          late final String label;
                          late final bool isCompleted;
                          if (task.isEmpty) {
                            label = 'No task';
                            isCompleted = false;
                          } else {
                            final completed =
                                task.where((task) => task.isCompleted);
                            if (completed.isEmpty) {
                              label = 'Start completing your task now!';
                              isCompleted = true;
                            } else {
                              label =
                                  '${completed.length} of ${task.length} Completed';
                              isCompleted = true;
                            }
                          }
                          return CustomedChip(
                            chipLayout: ScheduleEnum.today,
                            isCompleted: isCompleted,
                            label: label,
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 0.75.h),
                  Text(
                    DateTime.now().formatToDisplableView,
                    style: dateViewStyle,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
