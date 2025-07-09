import 'package:flutter/material.dart';
import 'package:flare_chat/res/helper_extensions.dart';

class ImageButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double height;
  final String imgPath, txt;
  final Color btnClr;
  final bool showImg;

  const ImageButton({
    super.key,
    required this.onPressed,
    this.height = 50,
    required this.imgPath,
    required this.btnClr,
    required this.txt,
    this.showImg = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: btnClr,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            if (showImg)
              Image.asset(
                imgPath,
                height: 50,
                width: 50,
              ),
            if (showImg) 5.pw,
            Text(
              txt,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: txt == 'Chat' ? 15 : 14,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
