import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

import '../../bloc/user/user_bloc.dart';

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
          onTap: () {
            context.read<UserBloc>().add(const WatchShowcaseEvent());
          },
          child: const Padding(
            padding: EdgeInsets.all(4.0),
            child: Icon(
              IconlyLight.info_square,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
