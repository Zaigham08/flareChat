import 'package:flutter/material.dart';

import '../../constants.dart';

class MyInputField extends StatelessWidget {
  final String hintText;
  final Color textColor;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Widget? widget;
  final bool readOnly, hidePassword, giveMargin;
  final ValueChanged<String>? onFieldSubmitted;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final double width;
  final IconData? icon;

  const MyInputField({
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
    this.icon, required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: width,
      margin: EdgeInsets.only(top: giveMargin ? 25 : 2),
      decoration: BoxDecoration(
        color: textFieldColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if(icon != null)
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: btnColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: txtColor,size: 28),
          ),
          Expanded(
            child: TextFormField(
              obscureText: hidePassword,
              readOnly: readOnly,
              controller: controller,
              focusNode: focusNode,
              validator: validator,
              keyboardType: keyboardType,
              onFieldSubmitted: onFieldSubmitted,
              textCapitalization: textCapitalization,
              style: TextStyle(
                color: textColor,
              ),
              cursorColor: textColor,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: textColor,
                ),
                contentPadding:
                    const EdgeInsets.only(left: 18, bottom: 2, right: 4),
                border: InputBorder.none,
              ),
            ),
          ),
          widget == null ? Container() : Container(child: widget),
        ],
      ),
    );
  }
}
