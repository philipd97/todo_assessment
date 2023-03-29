import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_assessment/bloc/user_tasks_bloc.dart';
import 'package:todo_assessment/helpers/enums_helper.dart';
import 'package:todo_assessment/helpers/sizer_helper.dart';
import 'package:todo_assessment/model/task.dart';
import 'package:todo_assessment/helpers/database_helper.dart';
import 'package:todo_assessment/views/widgets/custom_action_button.dart';
import 'package:todo_assessment/views/widgets/customed_chip.dart';
import 'package:todo_assessment/views/widgets/tile_checkbox.dart';

class TaskViewTab extends StatefulWidget {
  const TaskViewTab({super.key});

  @override
  State<TaskViewTab> createState() => _TaskViewTabState();
}

class _TaskViewTabState extends State<TaskViewTab> {
  Future<void> _getDBTest() async {
    // context.read<UserTaskBloc>().add(IncreaseCount());
    // final db = await DatabaseRepository.instance().database;
    // log('DATABASE: $db');
    // final result = await db.query('user');
    // log('result: $result');
    // final intResult = await db.insert(
    //   'tasks',
    //   Task(title: 'Title', date: DateTime.now()).toMap(),
    // );
    // log('intResult: $intResult');
    // final result2 = await db.query('tasks');
    // log('result2: $result2');
  }

  @override
  Widget build(BuildContext context) {
    final sidePadding = EdgeInsets.symmetric(horizontal: 5.w);

    return CustomScrollView(
      slivers: [
        SliverAppBar.medium(
          pinned: true,
          backgroundColor: Colors.grey[50],
          collapsedHeight:
              kToolbarHeight + MediaQuery.of(context).padding.top + 8.h,
          flexibleSpace: Padding(
            padding: sidePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top + 2.h),
                const Text(
                  'Welcome, username!',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
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
                            CustomedChip(
                              chipLayout: ScheduleEnum.today,
                            ),
                            CustomedChip(
                              chipLayout: ScheduleEnum.todayCompleted,
                              label: '1 of 4 Completed',
                            ),
                          ],
                        ),
                        SizedBox(height: 0.75.h),
                        Text(
                          '25 March 2023',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                    const CustomedActionButton(),
                  ],
                )
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: sidePadding,
          sliver: SliverReorderableList(
            itemCount: 4,
            onReorder: (oldIndex, newIndex) {},
            itemBuilder: (context, index) {
              return Container(
                clipBehavior: Clip.hardEdge,
                key: ValueKey(index),
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
                      print('are you tapped');
                    },
                    leading: const TileCheckbox(),
                    title: Text('title'),
                    subtitle: Row(
                      children: const [
                        CustomedChip(chipLayout: ScheduleEnum.today),
                        CustomedChip(chipLayout: ImportanceEnum.important),
                      ],
                    ),
                    trailing: ReorderableDragStartListener(
                      index: index,
                      child: const Icon(Icons.drag_handle),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SliverToBoxAdapter(
          child: TextButton(
            onPressed: () async => await _getDBTest(),
            child: Text('Test DB'),
          ),
        ),
      ],
    );
  }
}
