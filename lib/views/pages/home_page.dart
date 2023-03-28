import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';

import '../../gen/assets.gen.dart';
import '../widgets/home_tabs/calendar_view_tab.dart';
import '../widgets/home_tabs/tasks_view_tab.dart';
import 'task_detail_page.dart';

class HomePage extends HookWidget {
  static const routeName = '/home';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final index = useState<int>(0);

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
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            context.push(TaskDetailPage.routeName);
          },
          child: const Icon(Icons.add, size: 28.0),
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
            // TODO: check back on why color not changing active inactive
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(Assets.images.checklist.path),
                color: Colors.black.withOpacity(0.75),
              ),
              label: 'Testing',
            ),
            const BottomNavigationBarItem(
              icon: Icon(IconlyLight.calendar, color: Colors.black),
              label: 'Testing2',
            ),
          ],
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: index,
        builder: (_, currentIndex, __) {
          return IndexedStack(
            index: currentIndex,
            children: [
              TaskViewTab(),
              CalendarViewTab(),
            ],
          );
        },
      ),
    );
  }
}
