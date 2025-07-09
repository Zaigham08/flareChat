import 'package:flutter/material.dart';
import 'package:flare_chat/res/constants.dart';

class MyContainer extends StatelessWidget {
  final double? width, height, radius;
  final Widget child;
  final Color? color;
  final EdgeInsetsGeometry? padding, margin;

  const MyContainer({
    super.key,
    this.width,
    this.height,
    this.radius = 0,
    required this.child,
    this.padding,
    this.margin, this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: color ?? cardColor,
        borderRadius: BorderRadius.circular(radius!),
      ),
      child: child,
    );
  }
}
