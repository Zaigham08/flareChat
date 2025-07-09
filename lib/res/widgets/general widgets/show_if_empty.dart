import 'package:flutter/material.dart';
import 'package:flare_chat/res/helper_extensions.dart';

import '../../constants.dart';

Center showIfEmpty(String text) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline,
          color: txtColor.withValues(alpha: .5),
          size: 53,
        ),
        5.ph,
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: txtColor.withValues(alpha: .5),
          ),
        ),
      ],
    ),
  );
}