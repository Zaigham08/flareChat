import 'package:flutter/material.dart';

import '../../constants.dart';

class MyTextInputField extends StatelessWidget {
  final String hintText;
  final Color textColor;
  final Color? fieldColor;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Widget? widget;
  final int? maxLines;
  final bool readOnly, hidePassword, giveMargin;
  final ValueChanged<String>? onFieldSubmitted;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final double width;

  const MyTextInputField({
    super.key,
    required this.hintText,
    this.width = double.infinity,
    this.controller,
    this.widget,
    this.readOnly = false,
    this.hidePassword = false,
    this.giveMargin = true,
    this.focusNode,
    this.onFieldSubmitted,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.sentences,
    this.textColor = txtColor,
    this.maxLines,
    this.fieldColor, this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      width: width,
      margin: const EdgeInsets.only(top: 7),
      decoration: BoxDecoration(
        color: fieldColor ?? textFieldColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextFormField(
              obscureText: hidePassword,
              readOnly: readOnly,
              controller: controller,
              focusNode: focusNode,
              validator: validator,
              keyboardType: keyboardType,
              onFieldSubmitted: onFieldSubmitted,
              onChanged: onChanged,
              textCapitalization: textCapitalization,
              style: TextStyle(color: textColor),
              maxLines: maxLines,
              cursorColor: textColor,
              cursorErrorColor: btnColor,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w500,
                  color: dimColor,
                ),
                contentPadding: const EdgeInsets.only(
                  left: 18,
                  bottom: 2,
                  right: 4,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          widget == null
              ? Container()
              : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(child: widget),
              ),
        ],
      ),
    );
  }
}
