import 'package:flutter/material.dart';

class CustomSnackBar extends SnackBar {
  final String title;
  final Color backColor;
  final int time;

  CustomSnackBar({
    required this.backColor,
    required this.time,
    required this.title,
    super.key,
  }) : super(
          content: Text(title),
          backgroundColor: backColor,
          behavior: SnackBarBehavior.fixed,
          duration: Duration(seconds: time),
        );
}
