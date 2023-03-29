import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_assessment/bloc/user_tasks_bloc.dart';
import 'package:todo_assessment/views/pages/home_page.dart';
import 'package:todo_assessment/views/pages/starting_page.dart';
import 'package:todo_assessment/views/pages/task_detail_page.dart';
import 'package:todo_assessment/views/pages/task_entry_page.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription _subscription;
  String? username;

  GoRouterRefreshStream(Stream<String?> stream) {
    notifyListeners();
    // _subscription = stream.asBroadcastStream().listen(
    //   (name) {
    //     log('name state: $name');
    //     if (name == null) return;
    //     username = name;
    //     log('username: $username');
    //     notifyListeners();
    //   },
    //   onDone: () {
    //     if (username != null) {
    //       _subscription.cancel();
    //       log('stream cancelled');
    //     }
    //   },
    // );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

// TODO: add animation page transition
GoRouter routes(BuildContext context) {
  return GoRouter(
    refreshListenable:
        GoRouterRefreshStream(context.read<UserTaskBloc>().stream),
    redirect: (context, state) {
      final name = context.read<UserTaskBloc>().state;
      if (name != null) return HomePage.routeName;
      return null;
    },
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
        builder: (context, state) => const TaskDetailPage(),
      ),
      GoRoute(
        path: TaskEntryPage.routeName,
        builder: (context, state) => const TaskEntryPage(),
      ),
    ],
  );
}
