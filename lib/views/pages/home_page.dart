import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:todo_assessment/bloc/user/user_bloc.dart';
import 'package:todo_assessment/main.dart';

import '../../gen/assets.gen.dart';
import '../widgets/home_tabs/calendar_view_tab.dart';
import '../widgets/home_tabs/tasks_view_tab.dart';
import 'task_entry_page.dart';

class HomePage extends HookWidget {
  static const routeName = '/home';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final index = useState<int>(0);
    final userState = context.read<UserBloc>().state;

    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          if (!userState.watchedShowcase) {
            ShowCaseWidget.of(context).startShowCase([showcaseKey1]);
          }
        });
      },
      [userState],
    );

    return Scaffold(
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
          key: showcaseKey1,
          description: 'Click here to add task',
          disposeOnTap: true,
          onTargetClick: () => context.push(TaskEntryPage.routeName),
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
          onTap: (newIndex) => index.value = newIndex,
          items: [
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(Assets.images.checklist.path),
                color: Colors.black.withOpacity(0.75),
              ),
              label: 'Checklist',
            ),
            const BottomNavigationBarItem(
              icon: Icon(IconlyLight.calendar, color: Colors.black),
              label: 'Calendar',
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: index.value,
        children: const [
          TaskViewTab(),
          CalendarViewTab(),
        ],
      ),
    );
  }
}
