import 'package:flutter/material.dart';

class MyBorderButton extends StatelessWidget {
  final String text;
  final double width, height;
  final VoidCallback onPressed;
  final Color? color;

  const MyBorderButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.width,
    this.height = 50,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Center(
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            border: Border.all(
              color: color ?? Colors.red.withValues(alpha: .9),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10),
            color: Colors.transparent,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: color ?? Colors.red.withValues(alpha: .9),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
