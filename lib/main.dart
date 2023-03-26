import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_assessment/gen/fonts.gen.dart';
import 'package:todo_assessment/helpers/sizer_helper.dart';
import 'package:todo_assessment/views/starting_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        SizerHelper.getSize(constraint);
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'To Do Assessment',
          theme: ThemeData(
            primarySwatch: Colors.grey,
            fontFamily: FontFamily.sofiaSans,
          ),
          routerConfig: _routes,
        );
      },
    );
  }
}

final _routes = GoRouter(
  routes: [
    GoRoute(
      path: StartingPage.routeName,
      builder: (context, state) => const StartingPage(),
    ),
  ],
);
