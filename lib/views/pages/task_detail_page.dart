import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:todo_assessment/bloc/user/user_bloc.dart';
import 'package:todo_assessment/helpers/enums_helper.dart';
import 'package:todo_assessment/helpers/extension_helper.dart';
import 'package:todo_assessment/helpers/snackbar_helper.dart';
import 'package:todo_assessment/main.dart';
import 'package:todo_assessment/views/pages/home_page.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userState = context.read<UserBloc>().state;
      if (!userState.watchedShowcase) {
        ShowCaseWidget.of(context).startShowCase([
          editBtnShowcase,
          deleteBtnShowcase,
          markCompleteShowcase,
        ]);
      }
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          Showcase(
            key: editBtnShowcase,
            disposeOnTap: false,
            onTargetClick: () =>
                ShowCaseWidget.of(context).completed(editBtnShowcase),
            description: TextConst.showcaseEditTaskBtn,
            child: IconButton(
              onPressed: () =>
                  context.go(TaskEntryPage.routeName, extra: {'task': task}),
              icon: const Icon(Icons.edit_outlined),
            ),
          ),
          Showcase(
            key: deleteBtnShowcase,
            disposeOnTap: false,
            onTargetClick: () =>
                ShowCaseWidget.of(context).completed(deleteBtnShowcase),
            description: TextConst.showcaseDeleteTaskBtn,
            child: IconButton(
              onPressed: () async {
                final confirm = await decisionDialog(
                  context: context,
                  contentText: TextConst.confirmDeleteTask,
                );
                if (!confirm) return;
                if (context.mounted) {
                  context
                      .read<TaskBloc>()
                      .add(DeleteTaskEvent(taskId: task.id!));

                  showCustomSnackBar(
                    context: context,
                    text: TextConst.taskDeleted,
                  );

                  context.pop();
                }
              },
              icon: const Icon(IconlyLight.delete),
            ),
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
                    TextConst.taskName,
                    style: taskDetailLabelStyle,
                  ),
                  Text(
                    task.title!,
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
                            chipLayout: task.importanceEnum!,
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
              child: Showcase(
                key: markCompleteShowcase,
                disposeOnTap: false,
                onTargetClick: () {
                  ShowCaseWidget.of(context).completed(markCompleteShowcase);
                  context.go(HomePage.routeName);
                },
                description: TextConst.showcaseTaskCompletion,
                child: StartButton(
                    label: task.isCompleted
                        ? TextConst.markIncomplete
                        : TextConst.markComplete,
                    onPressed: () {
                      context.read<TaskBloc>().add(
                            CheckBoxTriggerEvent(
                              taskId: task.id!,
                              isCompleted: !task.isCompleted,
                            ),
                          );
                      showCustomSnackBar(
                        context: context,
                        text: TextConst.successMakeChanges,
                      );
                      context.pop();
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
