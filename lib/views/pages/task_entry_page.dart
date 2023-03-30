import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:todo_assessment/bloc/task/task_bloc.dart';
import 'package:todo_assessment/bloc/user/user_bloc.dart';
import 'package:todo_assessment/constants/layout_const.dart';
import 'package:todo_assessment/constants/text_const.dart';
import 'package:todo_assessment/helpers/enums_helper.dart';
import 'package:todo_assessment/helpers/extension_helper.dart';
import 'package:todo_assessment/helpers/sizer_helper.dart';
import 'package:todo_assessment/helpers/snackbar_helper.dart';
import 'package:todo_assessment/main.dart';
import 'package:todo_assessment/model/task.dart';
import 'package:todo_assessment/views/pages/task_detail_page.dart';
import 'package:todo_assessment/views/widgets/start_button.dart';

class TaskEntryPage extends HookWidget {
  final Task? task;

  static const routeName = '/task-entry';

  const TaskEntryPage({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final dateTime = useState<DateTime?>(task?.date);
    final importance = useState<ImportanceEnum?>(task?.importanceEnum);
    final titleController = useTextEditingController(text: task?.title);
    final descController = useTextEditingController(text: task?.description);
    final userState = context.read<UserBloc>().state;

    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!userState.watchedShowcase) {
            ShowCaseWidget.of(context).startShowCase([
              taskTitleShowKey,
              taskDescShowKey,
              taskDateShowKey,
              taskImportanceShowKey,
              saveTaskBtnShowKey,
            ]);
          }
        });
        return null;
      },
      [userState],
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
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
                  Showcase(
                    key: taskTitleShowKey,
                    disposeOnTap: false,
                    onTargetClick: () =>
                        ShowCaseWidget.of(context).completed(taskTitleShowKey),
                    description: TextConst.showcaseTaskTitleField,
                    child: TextField(
                      controller: titleController,
                      style: const TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.w600,
                      ),
                      textInputAction: TextInputAction.next,
                      maxLines: null,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 0.5.h),
                        labelText: TextConst.taskName,
                        labelStyle: const TextStyle(fontSize: 26.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Showcase(
                    key: taskDescShowKey,
                    disposeOnTap: false,
                    onTargetClick: () =>
                        ShowCaseWidget.of(context).completed(taskDescShowKey),
                    description: TextConst.showcaseTaskDescField,
                    child: TextField(
                      controller: descController,
                      style:
                          TextStyle(fontSize: 20.0, color: Colors.grey[600]!),
                      textInputAction: TextInputAction.done,
                      maxLines: null,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 0.5.h),
                        labelText: TextConst.description,
                        labelStyle: const TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Showcase(
                    key: taskDateShowKey,
                    disposeOnTap: false,
                    onTargetClick: () =>
                        ShowCaseWidget.of(context).completed(taskDateShowKey),
                    description: TextConst.showcaseDate,
                    child: Row(
                      children: [
                        const Icon(IconlyLight.calendar, size: 26.0),
                        SizedBox(width: 2.w),
                        TextButton(
                          onPressed: () async {
                            final now = DateTime.now();
                            final date = await showDatePicker(
                              context: context,
                              initialDate: now,
                              firstDate: DateTime(now.year - 10),
                              lastDate: DateTime(now.year + 5),
                            );
                            if (date == null) return;
                            dateTime.value = date;
                          },
                          child: Text(
                            dateTime.value == null
                                ? TextConst.date
                                : (dateTime.value)!.formatToDisplableView,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Showcase(
                    key: taskImportanceShowKey,
                    disposeOnTap: false,
                    onTargetClick: () => ShowCaseWidget.of(context)
                        .completed(taskImportanceShowKey),
                    description: TextConst.showcaseimportance,
                    child: Row(
                      children: [
                        const Icon(IconlyLight.swap, size: 26.0),
                        SizedBox(width: 2.w),
                        TextButton(
                          onPressed: () async {
                            final data = await showDialog<ImportanceEnum?>(
                              context: context,
                              builder: (context) =>
                                  const _SelectImportanceDialog(),
                            );
                            if (data == null) return;
                            importance.value = data;
                          },
                          child: Text(importance.value == null
                              ? TextConst.importance
                              : importance.value!.getString),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 1.h),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 2.h),
              child: Showcase(
                key: saveTaskBtnShowKey,
                description: TextConst.showcaseSaveTaskBtn,
                disposeOnTap: true,
                onTargetClick: () {
                  ShowCaseWidget.of(context).completed(saveTaskBtnShowKey);
                  context.push(
                    TaskDetailPage.routeName,
                    extra: {
                      'task': Task(
                        title: TextConst.showcaseTitle,
                        date: DateTime.now(),
                        importanceEnum: ImportanceEnum.veryImportant,
                        index: 1234124,
                        description: TextConst.showcaseDesc,
                      )
                    },
                  );
                },
                child: StartButton(
                  label: 'Save task',
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    final titleText = titleController.text.trim();
                    final descText = descController.text.trim();

                    if (titleText.isEmpty) {
                      showCustomSnackBar(
                        context: context,
                        text: TextConst.inputTaskTitle,
                      );
                      return;
                    }
                    if (dateTime.value == null) {
                      showCustomSnackBar(
                        context: context,
                        text: TextConst.inputTaskDate,
                      );
                      return;
                    }
                    if (importance.value == null) {
                      showCustomSnackBar(
                        context: context,
                        text: TextConst.inputTaskImportance,
                      );
                      return;
                    }

                    final isAdd = task == null || task?.id == null;
                    context.read<TaskBloc>().add(
                          isAdd
                              ? AddTaskEvent(
                                  title: titleText.trim(),
                                  description:
                                      descText.isEmpty ? null : descText.trim(),
                                  dateTime: dateTime.value!,
                                  importanceEnum: importance.value!,
                                )
                              : UpdateTaskEvent(
                                  taskId: task!.id!,
                                  title: titleController.text,
                                  description: descText.trim().isEmpty
                                      ? null
                                      : descText.trim(),
                                  dateTime: dateTime.value!,
                                  importanceEnum: importance.value!,
                                ),
                        );
                    context.pop();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectImportanceDialog extends StatelessWidget {
  const _SelectImportanceDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.hardEdge,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Choose Importance',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: ImportanceEnum.values.length,
            itemBuilder: (context, index) {
              final enumData = ImportanceEnum.values[index];
              return ListTile(
                title: Text(
                  enumData.getString,
                  style: TextStyle(
                    color: enumData.textColor,
                  ),
                ),
                tileColor: enumData.tileColor,
                onTap: () => Navigator.pop(
                  context,
                  enumData,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
