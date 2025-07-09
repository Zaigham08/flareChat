import 'package:flutter/material.dart';

import '../../constants.dart';

class BigInputField extends StatelessWidget {
  final String hintText;
  final Color textColor;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFieldSubmitted;
  final String? Function(String?)? validator;
  final double width, height, margin;
  final int? maxLines;
  final bool readOnly;

  const BigInputField({
    super.key,
    required this.hintText,
    this.maxLines,
    this.controller,
    this.focusNode,
    this.onFieldSubmitted,
    this.validator,
    required this.textColor,
    this.width = double.infinity,
    this.height = 100,
    this.margin = 22,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: textFieldColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        readOnly: readOnly,
        controller: controller,
        minLines: 1,
        maxLines: maxLines,
        focusNode: focusNode,
        validator: validator,
        onFieldSubmitted: onFieldSubmitted,
        textCapitalization: TextCapitalization.sentences,
        style: TextStyle(
          color: textColor,
        ),
        cursorColor: textColor,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 15,
            color: textColor,
            fontWeight: FontWeight.w400,
          ),
          contentPadding: const EdgeInsets.all(10),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
