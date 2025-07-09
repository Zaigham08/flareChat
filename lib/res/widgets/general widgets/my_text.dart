import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;
  final String? fontFamily;
  final Color? color, backgroundColor;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final TextBaseline? textBaseline;
  final TextLeadingDistribution? leadingDistribution;
  final Locale? locale;
  final Paint? foreground;
  final Paint? background;
  final List<Shadow>? shadows;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor, fontSize, letterSpacing, wordSpacing, height;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;

  const MyText(
    this.text, {
    super.key,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.color,
    this.backgroundColor,
    this.fontWeight,
    this.fontStyle,
    this.textBaseline,
    this.leadingDistribution,
    this.foreground,
    this.background,
    this.shadows,
    this.decoration,
    this.decorationColor,
    this.fontSize,
    this.letterSpacing,
    this.wordSpacing,
    this.height,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        backgroundColor: backgroundColor,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        fontFamily: fontFamily,
        textBaseline: textBaseline,
        leadingDistribution: leadingDistribution,
        locale: locale,
        foreground: foreground,
        background: background,
        shadows: shadows,
        decoration: decoration,
        decorationColor: decorationColor,
        fontSize: fontSize,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        height: height,
      ),
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
    );
  }
}
