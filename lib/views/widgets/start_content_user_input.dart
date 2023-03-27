import 'package:flutter/material.dart';
import 'package:todo_assessment/constants/text_const.dart';
import 'package:todo_assessment/gen/assets.gen.dart';
import 'package:todo_assessment/helpers/sizer_helper.dart';

class StartContentUserInput extends StatelessWidget {
  final TextEditingController controller;

  const StartContentUserInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 2.h),
          Assets.images.selfieOpendoodle.image(
            height: 50.h,
          ),
          const Text(
            TextConst.greeting,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
          ),
          SizedBox(height: 3.h),
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
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}
