import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showcaseview/showcaseview.dart';

import 'bloc/task/task_bloc.dart';
import 'bloc/user/user_bloc.dart';
import 'gen/fonts.gen.dart';
import 'helpers/database_helper.dart';
import 'helpers/routes_helper.dart';
import 'helpers/sizer_helper.dart';

final addTaskBtnShowcase = GlobalKey();
final calendarShowcase = GlobalKey();
final taskTitleShowKey = GlobalKey();
final taskDescShowKey = GlobalKey();
final taskDateShowKey = GlobalKey();
final taskImportanceShowKey = GlobalKey();
final saveTaskBtnShowKey = GlobalKey();
final editBtnShowcase = GlobalKey();
final deleteBtnShowcase = GlobalKey();
final markCompleteShowcase = GlobalKey();

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
            routerConfig: routers,
            builder: (context, child) => GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: ScrollConfiguration(
                behavior: NoGlowScrollBehaviour(),
                child: ShowCaseWidget(
                  disableBarrierInteraction: true,
                  onFinish: () {
                    context
                        .read<UserBloc>()
                        .add(const FinishFirstTimeShowcaseEvent());
                  },
                  builder: Builder(builder: (_) => child!),
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
