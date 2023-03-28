import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:todo_assessment/constants/layout_const.dart';
import 'package:todo_assessment/constants/text_const.dart';
import 'package:todo_assessment/helpers/enums_helper.dart';
import 'package:todo_assessment/helpers/sizer_helper.dart';
import 'package:todo_assessment/views/pages/task_entry_page.dart';
import 'package:todo_assessment/views/widgets/customed_chip.dart';
import 'package:todo_assessment/views/widgets/start_button.dart';

class TaskDetailPage extends StatelessWidget {
  static const routeName = '/task-detail';
  const TaskDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () => context.push(TaskEntryPage.routeName),
            icon: const Icon(Icons.edit_outlined),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  elevation: 0.0,
                  content: Text(
                    'are you sure you would like to delete this task?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {},
                      child: Text('Yes'),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('No'),
                    ),
                  ],
                ),
              );
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
                  const Text(
                    'Watering Plants In the morning evening',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 38.0,
                      height: 0.0,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      SizedBox(
                        height: 5.h,
                        child: FittedBox(
                          child: CustomedChip(
                            chipType: ChipTypeEnum.todayCompleted,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                        child: FittedBox(
                          child: CustomedChip(
                            chipType: ChipTypeEnum.important,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    TextConst.description,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey[500],
                      fontSize: 18.0,
                    ),
                  ),
                  Text('-'),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 2.h),
              child: StartButton(
                label: 'Mark as incomplete',
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
