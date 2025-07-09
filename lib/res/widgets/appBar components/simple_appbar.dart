import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flare_chat/res/constants.dart';
import 'package:flare_chat/res/widgets/general%20widgets/my_text.dart';

class MySimpleAppBar extends StatelessWidget {
  final String title;

  const MySimpleAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: whiteColor,
            size: 22,
          ),
        ),
        MyText(
          title,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        const MyText(""),
      ],
    );
  }
}
