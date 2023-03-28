import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:iconly/iconly.dart';
import 'package:todo_assessment/constants/layout_const.dart';
import 'package:todo_assessment/constants/text_const.dart';
import 'package:todo_assessment/gen/assets.gen.dart';
import 'package:todo_assessment/helpers/sizer_helper.dart';
import 'package:todo_assessment/views/widgets/start_button.dart';

class TaskEntryPage extends HookWidget {
  static const routeName = '/task-entry';

  const TaskEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = useTextEditingController();
    final descController = useTextEditingController();

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
                  TextField(
                    controller: titleController,
                    style: const TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.w600,
                    ),
                    textInputAction: TextInputAction.next,
                    maxLines: null,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 0.5.h),
                      labelText: 'Task Name',
                      labelStyle: const TextStyle(fontSize: 26.0),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  TextField(
                    controller: descController,
                    style: TextStyle(fontSize: 20.0, color: Colors.grey[600]!),
                    textInputAction: TextInputAction.done,
                    maxLines: null,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 0.5.h),
                      labelText: TextConst.description,
                      labelStyle: const TextStyle(fontSize: 20.0),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      const Icon(IconlyLight.calendar, size: 26.0),
                      SizedBox(width: 2.w),
                      TextButton(
                        onPressed: () {},
                        child: Text('29th March 2023'),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      const Icon(IconlyLight.swap, size: 26.0),
                      SizedBox(width: 2.w),
                      TextButton(
                        onPressed: () {},
                        child: Text('Importance'),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 2.h),
              child: StartButton(
                label: 'Save task',
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
