import 'package:flutter/material.dart';
import '../../gen/colors.gen.dart';

class TileCheckbox extends StatefulWidget {
  const TileCheckbox({super.key});

  @override
  State<TileCheckbox> createState() => _TileCheckboxState();
}

class _TileCheckboxState extends State<TileCheckbox> {
  bool _isChecked = false;

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
              _isChecked ? ColorName.todayCompletedTile : Colors.transparent),
          activeColor: Colors.transparent,
          checkColor: Colors.black,
          shape: const CircleBorder(),
          onChanged: (value) => setState(() => _isChecked = value!),
        ),
      ),
    );
  }
}
