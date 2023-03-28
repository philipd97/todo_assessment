import 'package:go_router/go_router.dart';
import 'package:todo_assessment/views/pages/home_page.dart';
import 'package:todo_assessment/views/pages/starting_page.dart';
import 'package:todo_assessment/views/pages/task_detail_page.dart';
import 'package:todo_assessment/views/pages/task_entry_page.dart';

// TODO: add animation page transition
final routes = GoRouter(
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
