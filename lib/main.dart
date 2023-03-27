import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'gen/fonts.gen.dart';
import 'helpers/routes_helper.dart';
import 'helpers/sizer_helper.dart';

// TODO: add detail task screen/popup
// TODO: add sqlite
// TODO: add finished task
// TODO: add task overlay
// TODO: loading overlay

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
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
          routerConfig: routes,
          builder: (context, child) => GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: ScrollConfiguration(
              behavior: NoGlowScrollBehaviour(),
              child: child!,
            ),
          ),
        );
      },
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
