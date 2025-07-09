import 'package:flare_chat/res/constants.dart';
import 'package:flutter/material.dart';

class RedIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final double height, width, iconSize;

  const RedIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.height = 40,
    this.width = 40,
    this.iconSize = 37,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        margin: const EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Icon(icon, size: iconSize, color: whiteColor),
        ),
      ),
    );
  }
}
