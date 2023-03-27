import 'package:go_router/go_router.dart';
import 'package:todo_assessment/views/pages/home_page.dart';
import 'package:todo_assessment/views/pages/starting_page.dart';

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
  ],
);
