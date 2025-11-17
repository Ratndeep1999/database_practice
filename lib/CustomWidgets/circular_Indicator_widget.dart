import 'package:flutter/material.dart';

class CircularIndicatorWidget extends StatelessWidget {
  const CircularIndicatorWidget({
    super.key,
    this.strokeWidth,
    this.strokeAlign,
  });

  final double? strokeWidth;
  final double? strokeAlign;

  @override
  Widget build(BuildContext _) {
    return CircularProgressIndicator(
      color: Colors.orange,
      strokeWidth: strokeWidth ?? 15.0,
      strokeAlign: strokeAlign ?? 10.0,
    );
  }
}
