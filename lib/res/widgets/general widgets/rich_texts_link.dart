import 'package:flutter/material.dart';
import '../../constants.dart'; // Import your SignUpPage

class MyRichTextsLink extends StatelessWidget {
  final String text1, text2;
  final double fontSize, text1ColorOpacity;
  final Color text1Color, text2Color;
  final VoidCallback onPressed;

  const MyRichTextsLink({
    super.key,
    required this.onPressed,
    required this.text1,
    required this.text2,
    this.fontSize = 14.5,
    this.text1Color = txtColor,
    this.text1ColorOpacity = 0.8,
    this.text2Color = txtColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: RichText(
        text: TextSpan(
          text: text1,
          style: TextStyle(
            color: text1Color.withValues(alpha: text1ColorOpacity),
            fontSize: fontSize,
          ),
          children: [
            TextSpan(
              text: text2,
              style: TextStyle(
                fontSize: fontSize,
                color: text2Color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
