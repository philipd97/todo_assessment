import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_assessment/constants/text_const.dart';
import 'package:todo_assessment/views/pages/home_page.dart';
import 'package:todo_assessment/views/widgets/start_button.dart';

import '../../helpers/sizer_helper.dart';
import '../widgets/start_content_intro.dart';
import '../widgets/start_content_user_input.dart';

class StartingPage extends HookWidget {
  static const routeName = '/';

  const StartingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pageListener = useState<int>(0);
    final pageController = usePageController();
    final textController = useTextEditingController();

    useEffect(
      () {
        void listener() =>
            pageListener.value = pageController.page?.toInt() ?? 0;
        pageController.addListener(listener);
        return () => pageController.removeListener(listener);
      },
      [pageController],
    );

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  const StartContentIntro(),
                  StartContentUserInput(controller: textController),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 2.h, bottom: 3.h),
              child: ValueListenableBuilder(
                valueListenable: pageListener,
                builder: (_, page, __) {
                  final pageIsFirst = page == 0;
                  return StartButton(
                    label:
                        pageIsFirst ? TextConst.getStarted : TextConst.proceed,
                    onPressed: () {
                      if (pageIsFirst) {
                        pageController.animateToPage(
                          1,
                          duration: const Duration(milliseconds: 900),
                          curve: Curves.easeInOutQuint,
                        );
                      } else {
                        if (textController.text.trim().isEmpty) {
                          // TODO: refactor this
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text('We\'d like to know your name :('),
                          ));
                          return;
                        }
                        context.go(HomePage.routeName);
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
