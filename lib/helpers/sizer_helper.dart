import 'dart:developer';

import 'package:flutter/material.dart';

class SizerHelper {
  late BoxConstraints constraint;

  static final _instance = SizerHelper._();

  SizerHelper._();

  factory SizerHelper.getSize(BoxConstraints constraint) {
    _instance.constraint = constraint;
    return _instance;
  }
}

extension Sizing on num {
  double get w => (this / 100) * SizerHelper._instance.constraint.maxWidth;
  double get h => (this / 100) * SizerHelper._instance.constraint.maxHeight;
}
