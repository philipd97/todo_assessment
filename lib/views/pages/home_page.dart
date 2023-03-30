import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:todo_assessment/bloc/user/user_bloc.dart';
import 'package:todo_assessment/constants/text_const.dart';

import 'package:todo_assessment/main.dart';

import '../../gen/assets.gen.dart';
import '../widgets/home_tabs/calendar_view_tab.dart';
import '../widgets/home_tabs/tasks_view_tab.dart';
import 'task_entry_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _index = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userState = context.read<UserBloc>().state;

      if (!userState.watchedShowcase) _triggerShowCase();
    });
  }

  void _triggerShowCase() {
    ShowCaseWidget.of(context).startShowCase([
      calendarShowcase,
      addTaskBtnShowcase,
    ]);
  }

  @override
  void dispose() {
    _index.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listenWhen: (previous, current) =>
          previous.watchedShowcase != current.watchedShowcase,
      listener: (context, state) {
        if (!state.watchedShowcase) _triggerShowCase();
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0.0, -3.0),
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10.0,
              )
            ],
          ),
          child: Showcase(
            disposeOnTap: true,
            key: addTaskBtnShowcase,
            description: TextConst.showcaseAddTask,
            disableDefaultTargetGestures: true,
            onTargetClick: () {
              ShowCaseWidget.of(context).completed(addTaskBtnShowcase);
              context.push(TaskEntryPage.routeName);
            },
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                context.push(TaskEntryPage.routeName);
              },
              child: const Icon(Icons.add, size: 28.0),
            ),
          ),
        ),
        bottomNavigationBar: DecoratedBox(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: const Offset(0.0, -3.0),
                color: Colors.black.withOpacity(0.1),
                blurRadius: 15.0,
              ),
            ],
          ),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: Colors.white,
            onTap: (newIndex) => _index.value = newIndex,
            items: [
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage(Assets.images.checklist.path),
                  color: Colors.black.withOpacity(0.75),
                ),
                label: 'Checklist',
              ),
              BottomNavigationBarItem(
                icon: Showcase(
                  key: calendarShowcase,
                  disposeOnTap: false,
                  onTargetClick: () =>
                      ShowCaseWidget.of(context).completed(calendarShowcase),
                  description: TextConst.showcaseCalendarView,
                  child: const Icon(IconlyLight.calendar, color: Colors.black),
                ),
                label: 'Calendar',
              ),
            ],
          ),
        ),
        body: IndexedStack(
          index: _index.value,
          children: const [
            TaskViewTab(),
            CalendarViewTab(),
          ],
        ),
      ),
    );
  }
}
