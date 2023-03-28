import 'package:flutter/material.dart';
import 'package:todo_assessment/helpers/enums_helper.dart';
import 'package:todo_assessment/helpers/sizer_helper.dart';
import 'package:todo_assessment/views/widgets/custom_action_button.dart';
import 'package:todo_assessment/views/widgets/customed_chip.dart';
import 'package:todo_assessment/views/widgets/tile_checkbox.dart';

class TaskViewTab extends StatelessWidget {
  const TaskViewTab({super.key});

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
                              chipType: ChipTypeEnum.todayIncompleteTile,
                            ),
                            CustomedChip(
                              chipType: ChipTypeEnum.todayCompleted,
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
                      children: [
                        CustomedChip(chipType: ChipTypeEnum.todayIncompleteTile),
                        CustomedChip(chipType: ChipTypeEnum.important),
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
      ],
    );
  }
}
