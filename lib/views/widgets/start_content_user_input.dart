import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todo_assessment/constants/text_const.dart';
import 'package:todo_assessment/gen/assets.gen.dart';
import 'package:todo_assessment/helpers/sizer_helper.dart';
import 'package:todo_assessment/views/widgets/start_button.dart';

class StartContentUserInput extends HookWidget {
  const StartContentUserInput({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Assets.images.selfieOpendoodle.image(),
        const Text(
          TextConst.greeting,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
          ),
        ),
        SizedBox(height: 3.5.h),
        TextField(
          controller: controller,
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            hintText: TextConst.youCanCallMe,
            hintStyle: TextStyle(
              fontSize: 18.0,
              fontStyle: FontStyle.italic,
              color: Color(0xFFABABAB),
            ),
          ),
        ),
        SizedBox(height: 5.h),
        StartButton(
          label: TextConst.proceed,
          onPressed: () {},
        ),
      ],
    );
  }
}
