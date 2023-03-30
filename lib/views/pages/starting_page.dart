import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_assessment/bloc/task/task_bloc.dart';
import 'package:todo_assessment/bloc/user/user_bloc.dart';
import 'package:todo_assessment/constants/text_const.dart';
import 'package:todo_assessment/helpers/snackbar_helper.dart';
import 'package:todo_assessment/views/pages/home_page.dart';
import 'package:todo_assessment/views/widgets/dialogs/loading_dialog.dart';
import 'package:todo_assessment/views/widgets/start/start_content_intro.dart';
import 'package:todo_assessment/views/widgets/start/start_content_user_input.dart';
import 'package:todo_assessment/views/widgets/start_button.dart';

import '../../helpers/sizer_helper.dart';

class StartingPage extends HookWidget {
  static const routeName = '/';

  const StartingPage({super.key});

  void _onClickButton({
    required PageController pageController,
    required BuildContext context,
    required TextEditingController textController,
  }) async {
    if (pageController.page?.toInt() == 0) {
      pageController.animateToPage(
        1,
        duration: const Duration(milliseconds: 900),
        curve: Curves.easeInOutQuint,
      );
    } else {
      FocusManager.instance.primaryFocus?.unfocus();

      final username = textController.text.trim();

      if (username.isEmpty) {
        showCustomSnackBar(context: context, text: TextConst.enterName);
        return;
      }

      context.read<UserBloc>().add(InputUsernameEvent(username: username));
    }
  }

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

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingOverlay.instance().show(context: context);
        } else {
          LoadingOverlay.instance().hide();
        }
        if (state.username != null) {
          context.read<TaskBloc>().add(const FetchTasksEvent());
          context.go(HomePage.routeName);
        }
      },
      child: Scaffold(
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
                    StartContentUserInput(
                      controller: textController,
                      onSubmitted: (_) => _onClickButton(
                        pageController: pageController,
                        context: context,
                        textController: textController,
                      ),
                    ),
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
                      label: pageIsFirst
                          ? TextConst.getStarted
                          : TextConst.proceed,
                      onPressed: () => _onClickButton(
                        pageController: pageController,
                        context: context,
                        textController: textController,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
