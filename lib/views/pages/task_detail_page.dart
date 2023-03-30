import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:todo_assessment/helpers/enums_helper.dart';
import 'package:todo_assessment/helpers/extension_helper.dart';
import 'package:todo_assessment/helpers/snackbar_helper.dart';

import '../../bloc/task/task_bloc.dart';
import '../../constants/layout_const.dart';
import '../../constants/text_const.dart';
import '../../helpers/sizer_helper.dart';
import '../../model/task.dart';
import '../widgets/customed_chip.dart';
import '../widgets/dialogs/decision_dialog.dart';
import '../widgets/start_button.dart';
import 'task_entry_page.dart';

class TaskDetailPage extends StatelessWidget {
  final Task task;

  static const routeName = '/task-detail';

  const TaskDetailPage({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () =>
                context.go(TaskEntryPage.routeName, extra: {'task'}),
            icon: const Icon(Icons.edit_outlined),
          ),
          IconButton(
            onPressed: () async {
              final confirm = await decisionDialog(
                context: context,
                contentText: 'Are you sure you would like to delete this task?',
              );
              if (!confirm) return;
              if (context.mounted) {
                context.read<TaskBloc>().add(DeleteTaskEvent(taskId: task.id!));
                showCustomSnackBar(context: context, text: 'Task deleted!');
                context.pop();
              }
            },
            icon: const Icon(IconlyLight.delete),
          ),
        ],
      ),
      body: Padding(
        padding: sidePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Task name',
                    style: taskDetailLabelStyle,
                  ),
                  Text(
                    task.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 38.0,
                      height: 0.0,
                      decoration:
                          task.isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      SizedBox(
                        height: 5.h,
                        child: FittedBox(
                          child: CustomedChip(
                            chipLayout: task.scheduleEnum,
                            isCompleted: task.isCompleted,
                            label: task.scheduleEnum == ScheduleEnum.today
                                ? null
                                : task.date.formatToDisplableView,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                        child: FittedBox(
                          child: CustomedChip(
                            chipLayout: task.importanceEnum,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  if (task.description != null) ...[
                    Text(
                      TextConst.description,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey[500],
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      task.description!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                        height: 0.0,
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                  ]
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 2.h),
              child: StartButton(
                  label: task.isCompleted
                      ? 'Mark as Incomplete'
                      : 'Mark as Complete',
                  onPressed: () {
                    context.read<TaskBloc>().add(
                          CheckBoxTriggerEvent(
                            taskId: task.id!,
                            isCompleted: !task.isCompleted,
                          ),
                        );
                    showCustomSnackBar(
                      context: context,
                      text: 'Successfully make changes!',
                    );
                    context.pop();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
