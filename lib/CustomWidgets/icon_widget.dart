import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  const IconWidget({
    super.key,
    this.iconPress,
    this.icon,
    this.iconSize,
    this.iconColor,
  });

  final VoidCallback? iconPress;
  final IconData? icon;
  final double? iconSize;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: iconPress,
      child: Icon(icon, size: iconSize, color: iconColor),
    );
  }
}
