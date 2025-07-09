import 'package:flutter/material.dart';

import '../../constants.dart';
import '../general widgets/my_text.dart';

AppBar myAppBar(String title) {
  return AppBar(title: MyText(title, color: whiteColor), centerTitle: true);
}
