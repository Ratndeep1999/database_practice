import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  const IconWidget({
    super.key,
    required this.iconPress,
    required this.icon,
    this.iconSize,
    this.iconColor,
  });

  final VoidCallback iconPress;
  final IconData icon;
  final double? iconSize;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: iconPress,
      icon: Icon(icon, size: iconSize, color: iconColor),
    );
  }
}
