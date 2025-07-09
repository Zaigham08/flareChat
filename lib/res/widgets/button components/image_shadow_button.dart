import 'package:flutter/material.dart';
import 'package:flare_chat/res/helper_extensions.dart';

import '../../constants.dart';

class ImageShadowButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double height, width;
  final String imgPath, txt;

  const ImageShadowButton({
    super.key,
    required this.onPressed,
    this.height = 50,
    this.width = 450,
    required this.imgPath, required this.txt,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.5), // Shadow color
              spreadRadius: 1.5, // Spread radius
              blurRadius: 3, // Blur radius
              offset:
                  const Offset(2, 2), // Offset in the bottom-right direction
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imgPath,
              height: 24,
              width: 24,
            ),
            20.pw,
            Text(
              txt,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: txtColor,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
