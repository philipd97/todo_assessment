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
    final dateTime = useState<DateTime?>(null);
    final importance = useState<ImportanceEnum?>(null);
    final titleController = useTextEditingController(text: task?.title);
    final descController = useTextEditingController(text: task?.description);
    final userState = context.read<UserBloc>().state;

    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          if (!userState.watchedShowcase) {
            ShowCaseWidget.of(context).startShowCase([
              showcaseKey2,
              showcaseKey3,
              showcaseKey4,
              showcaseKey5,
              showcaseKey6,
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
                    key: showcaseKey2,
                    description: 'Here is the field to put your task title',
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
                        labelText: 'Task Name',
                        labelStyle: const TextStyle(fontSize: 26.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Showcase(
                    key: showcaseKey3,
                    description:
                        'Here is the field to put your task description',
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
                    key: showcaseKey4,
                    description: 'Choose the date of your task',
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
                                ? 'Date'
                                : (dateTime.value)!.formatToDisplableView,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Showcase(
                    key: showcaseKey5,
                    description: 'Select the importance of your task',
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
                              ? 'Importance'
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
                key: showcaseKey6,
                description: 'Click Save task & preview the next page',
                disposeOnTap: true,
                onTargetClick: () {
                  context.push(
                    TaskDetailPage.routeName,
                    extra: {
                      'task': Task(
                        title: 'This is a preview task generated by Philip.',
                        date: DateTime.now(),
                        importanceEnum: ImportanceEnum.veryImportant,
                        index: 1234124,
                        description:
                            'This is a testing description generated by Philip.',
                      )
                    },
                  );
                  log('finish');
                },
                child: StartButton(
                  label: 'Save task',
                  onPressed: () {
                    if (titleController.text.trim().isEmpty) {
                      showCustomSnackBar(
                        context: context,
                        text: 'Please enter your task\'s title',
                      );
                      return;
                    }
                    if (dateTime.value == null) {
                      showCustomSnackBar(
                        context: context,
                        text: 'Please input the task\'s date',
                      );
                      return;
                    }
                    if (importance.value == null) {
                      showCustomSnackBar(
                        context: context,
                        text: 'Please input the task\'s importance',
                      );
                      return;
                    }
                    context.read<TaskBloc>().add(
                          AddTaskEvent(
                            title: titleController.text.trim(),
                            description: descController.text.trim().isEmpty
                                ? null
                                : descController.text.trim(),
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
