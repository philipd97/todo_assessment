import 'package:flutter/material.dart';
import 'package:todo_assessment/constants/text_const.dart';
import 'package:todo_assessment/gen/assets.gen.dart';
import 'package:todo_assessment/gen/colors.gen.dart';
import 'package:todo_assessment/helpers/sizer_helper.dart';
import 'package:todo_assessment/views/widgets/start_button.dart';

class StartContentIntro extends StatelessWidget {
  final VoidCallback getStartTap;

  const StartContentIntro({super.key, required this.getStartTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Assets.images.readingOpendoodle.image(
          fit: BoxFit.fitWidth,
          height: 30.h,
        ),
        SizedBox(height: 3.h),
        const Text(
          TextConst.todo,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 80.0,
          ),
        ),
        const _StartDescWidget(text: TextConst.startDesc1),
        const _StartDescWidget(text: TextConst.startDesc2),
        const _StartDescWidget(text: TextConst.startDesc3),
        SizedBox(height: 3.h),
        StartButton(label: TextConst.getStarted, onPressed: getStartTap),
      ],
    );
  }
}

class _StartDescWidget extends StatelessWidget {
  final String text;

  const _StartDescWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.25.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check),
          SizedBox(width: 3.w),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 20.0,
                fontStyle: FontStyle.italic,
                color: ColorName.startPageDesc,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
