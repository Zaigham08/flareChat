import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flare_chat/res/constants.dart';

class MyIconAppBar extends StatelessWidget {
  const MyIconAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: whiteColor,
            size: 22,
          ),
        ),
        SvgPicture.asset(
          "assets/svgs/app_icon.svg",
          height: 27,
          width: 98,
        ),
        const Text(""),
      ],
    );
  }
}
