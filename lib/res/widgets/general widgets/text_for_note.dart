import 'package:flutter/material.dart';

import '../../constants.dart';

Align myTextForNote(String text) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.only(left: 3.8, top: 2.8),
      child: Text(
        text,
        style: TextStyle(fontSize: 12.5, color: txtColor.withValues(alpha: .9)),
      ),
    ),
  );
}