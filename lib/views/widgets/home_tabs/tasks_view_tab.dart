import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../bloc/task/task_bloc.dart';
import '../../../gen/assets.gen.dart';
import '../../../helpers/sizer_helper.dart';
import '../dialogs/loading_dialog.dart';
import '../sliver_task_builder.dart';
import 'task_view_header.dart';

class TaskViewTab extends HookWidget {
  const TaskViewTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskBloc, TaskState>(
      listenWhen: (previous, current) =>
          previous.isLoading != current.isLoading,
      listener: (context, state) {
        if (state.isLoading) {
          LoadingOverlay.instance().show(context: context);
        } else {
          LoadingOverlay.instance().hide();
        }
      },
      child: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            pinned: true,
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.grey[50],
            collapsedHeight:
                kToolbarHeight + MediaQuery.of(context).padding.top + 8.h,
            flexibleSpace: const TaskViewHeader(),
          ),
          // Today Task
          BlocBuilder<TaskBloc, TaskState>(
            builder: (context, state) {
              final list = state.tasks;
              if (list.isEmpty) {
                return SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Assets.images.messyOpendoodle.image(
                        height: 30.h,
                      ),
                      const Align(
                        child: Text(
                          'No task on hand currently',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return SliverTaskBuilder(tasks: list);
            },
          ),
        ],
      ),
    );
  }
}
