import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class MyAutoSizeText extends StatelessWidget {
  final String text;
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

  const MyAutoSizeText(
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
      });

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: TextStyle(
        color: color,
        backgroundColor: backgroundColor,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
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
    );
  }
}
