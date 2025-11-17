import 'package:flutter/material.dart';

class LabelWidget extends StatelessWidget {
  const LabelWidget({
    super.key,
    required this.label,
    required this.fontSize,
    this.fontWeight,
    required this.fontColor,
    this.letterSpacing,
  });

  // parameters
  final String label;
  final double fontSize;
  final FontWeight? fontWeight;
  final Color fontColor;
  final double? letterSpacing;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.w700,
        color: fontColor,
        letterSpacing: letterSpacing,
      ),
    );
  }
}
