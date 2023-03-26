import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../helpers/sizer_helper.dart';
import 'widgets/start_content_intro.dart';
import 'widgets/start_content_user_input.dart';

class StartingPage extends HookWidget {
  static const routeName = '/';

  const StartingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: [
            StartContentIntro(
              getStartTap: () => pageController.animateToPage(
                1,
                duration: const Duration(milliseconds: 1500),
                curve: Curves.ease,
              ),
            ),
            const StartContentUserInput(),
          ],
        ),
      ),
    );
  }
}
