import 'package:flutter/material.dart';

class CustomColors {
  static final CustomColors _instance = CustomColors._internal();

  factory CustomColors() {
    return _instance;
  }

  CustomColors._internal();

  Color get warningColor => Colors.yellow;
  Color get errorColor => Colors.red;
  Color get successColor => Colors.green;
}
