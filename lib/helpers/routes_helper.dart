import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_assessment/model/task.dart';
import 'package:todo_assessment/views/pages/home_page.dart';
import 'package:todo_assessment/views/pages/previous_task_page.dart';
import 'package:todo_assessment/views/pages/starting_page.dart';
import 'package:todo_assessment/views/pages/task_detail_page.dart';
import 'package:todo_assessment/views/pages/task_entry_page.dart';

GoRouter routes(BuildContext context) {
  return GoRouter(
    routes: [
      GoRoute(
        path: StartingPage.routeName,
        builder: (context, state) => const StartingPage(),
      ),
      GoRoute(
        path: HomePage.routeName,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: TaskDetailPage.routeName,
        builder: (context, state) => TaskDetailPage(
          task: (state.extra as Map<String, dynamic>)['task'] as Task,
        ),
      ),
      GoRoute(
        path: TaskEntryPage.routeName,
        builder: (context, state) => TaskEntryPage(
          task: (state.extra as Map<String, dynamic>?)?['task'] as Task?,
        ),
      ),
      GoRoute(
        path: PreviousTaskPage.routeName,
        builder: (context, state) => const PreviousTaskPage(),
      ),
    ],
  );
}
