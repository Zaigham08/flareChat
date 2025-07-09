import 'package:flutter/material.dart';
import '../../constants.dart'; // Import your SignUpPage

class MyRichTexts extends StatelessWidget {
  final String text1, text2;
  final String? text3, fontFamily;
  final double fontSize;
  final double? letterSpacing, height;
  final Color text1Color, text2Color, text3Color;
  final bool isText1Bold, isText2Bold, isText3Bold;
  final TextAlign textAlign;

  const MyRichTexts({
    super.key,
    required this.text1,
    required this.text2,
    this.fontSize = 15.5,
    this.text1Color = txtColor,
    this.text2Color = txtColor,
    this.text3Color = txtColor,
    this.isText1Bold = true,
    this.isText2Bold = false,
    this.isText3Bold = false,
    this.fontFamily,
    this.height,
    this.text3, this.letterSpacing,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign,
      text: TextSpan(
        text: text1,
        style: TextStyle(
          color: text1Color,
          fontSize: fontSize,
          letterSpacing: letterSpacing,
          height: height,
          fontFamily: fontFamily ?? 'Raleway',
          fontWeight: isText1Bold ? FontWeight.bold : FontWeight.w500,
        ),
        children: [
          TextSpan(
            text: text2,
            style: TextStyle(
              color: text2Color,
              fontSize: fontSize,
              letterSpacing: letterSpacing,
              height: height,
              fontFamily: fontFamily ?? 'Raleway',
              fontWeight: isText2Bold ? FontWeight.bold : FontWeight.w500,
            ),
          ),
          if (text3 != null)
            TextSpan(
              text: text3,
              style: TextStyle(
                color: text3Color,
                fontSize: fontSize,
                letterSpacing: letterSpacing,
                height: height,
                fontFamily: fontFamily ?? 'Raleway',
                fontWeight: isText3Bold ? FontWeight.bold : FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }
}

class MyDynamicRichTexts extends StatelessWidget {
  final List<DynamicText> texts;
  final String? fontFamily;
  final double fontSize;

  const MyDynamicRichTexts({
    super.key,
    required this.texts,
    this.fontSize = 15.5,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: texts.map((dynamicText) {
          return TextSpan(
            text: dynamicText.text,
            style: TextStyle(
              color: dynamicText.color,
              fontSize: fontSize,
              fontFamily: fontFamily ?? 'Raleway',
              fontWeight:
                  dynamicText.isBold ? FontWeight.bold : FontWeight.w400,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class DynamicText {
  final String text;
  final Color color;
  final bool isBold;

  const DynamicText({
    required this.text,
    required this.color,
    this.isBold = false,
  });
}
