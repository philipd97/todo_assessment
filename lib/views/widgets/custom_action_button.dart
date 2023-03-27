import 'package:flutter/material.dart';
import 'package:todo_assessment/helpers/sizer_helper.dart';

class CustomedActionButton extends StatelessWidget {
  const CustomedActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: 50.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[100],
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(0, 3),
            blurRadius: 2.0,
            spreadRadius: 0.25,
          ),
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        shape: const CircleBorder(),
        child: InkWell(
          borderRadius: BorderRadius.circular(30.0),
          onTap: () {},
          child: const Padding(
            padding: EdgeInsets.all(4.0),
            child: Icon(
              Icons.notifications_active_outlined,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}