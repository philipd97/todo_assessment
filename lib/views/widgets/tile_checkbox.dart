import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_assessment/bloc/task/task_bloc.dart';
import '../../gen/colors.gen.dart';

class TileCheckbox extends StatefulWidget {
  final bool isCompleted;
  final void Function(bool onChanged) onChanged;

  const TileCheckbox({
    super.key,
    required this.isCompleted,
    required this.onChanged,
  });

  @override
  State<TileCheckbox> createState() => _TileCheckboxState();
}

class _TileCheckboxState extends State<TileCheckbox> {
  late bool _isChecked = widget.isCompleted;

  @override
  void didUpdateWidget(covariant TileCheckbox oldWidget) {
    if (oldWidget.isCompleted != widget.isCompleted &&
        _isChecked != widget.isCompleted) {
      setState(() {
        _isChecked = widget.isCompleted;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  void _onChanged(bool? value) {
    widget.onChanged(value!);
    setState(() => _isChecked = value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      padding: const EdgeInsets.all(1.5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      child: Theme(
        data: ThemeData(unselectedWidgetColor: Colors.white),
        child: Checkbox(
          value: _isChecked,
          fillColor: MaterialStatePropertyAll(
            _isChecked ? ColorName.todayCompletedTile : Colors.transparent,
          ),
          activeColor: Colors.transparent,
          checkColor: Colors.black,
          shape: const CircleBorder(),
          onChanged: _onChanged,
        ),
      ),
    );
  }
}
