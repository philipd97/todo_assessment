import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:todo_assessment/bloc/task/task_bloc.dart';
import 'package:todo_assessment/bloc/user/user_bloc.dart';
import 'package:todo_assessment/helpers/database_helper.dart';

import 'gen/fonts.gen.dart';
import 'helpers/routes_helper.dart';
import 'helpers/sizer_helper.dart';

final showcaseKey1 = GlobalKey();
final showcaseKey2 = GlobalKey();
final showcaseKey3 = GlobalKey();
final showcaseKey4 = GlobalKey();
final showcaseKey5 = GlobalKey();
final showcaseKey6 = GlobalKey();
final showcaseKey7 = GlobalKey();
final showcaseKey8 = GlobalKey();
final showcaseKey9 = GlobalKey();

// TODO: add able to showcase the widgets once click ? icon at home

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => UserBloc(DatabaseHelper.instance())
              ..add(const FetchUsernameEvent())),
        BlocProvider(create: (_) => TaskBloc(DatabaseHelper.instance())),
      ],
      child: LayoutBuilder(
        builder: (context, constraint) {
          SizerHelper.getSize(constraint);
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'To Do Assessment',
            theme: ThemeData(
              useMaterial3: true,
              primarySwatch: Colors.grey,
              fontFamily: FontFamily.sofiaSans,
            ),
            routerConfig: routes(context),
            builder: (context, child) => GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: ScrollConfiguration(
                behavior: NoGlowScrollBehaviour(),
                child: ShowCaseWidget(
                  onFinish: () {
                    // context
                    //     .read<UserBloc>()
                    //     .add(const FinishShowCaseEvent(watchedShowcase: true));
                  },
                  builder: Builder(builder: (context) {
                    return child!;
                  }),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class NoGlowScrollBehaviour extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
