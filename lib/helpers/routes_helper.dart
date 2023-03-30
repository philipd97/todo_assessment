import 'package:go_router/go_router.dart';

import '../model/task.dart';
import '../views/pages/home_page.dart';
import '../views/pages/starting_page.dart';
import '../views/pages/task_detail_page.dart';
import '../views/pages/task_entry_page.dart';

final routers = GoRouter(
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
  ],
);
