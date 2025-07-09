import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flare_chat/res/helper_extensions.dart';

import 'my_text.dart';

class ImgWithText extends StatelessWidget {
  final String imgPath, text;
  final double? textSize;
  final String? svgPath, fontFamily;

  const ImgWithText({
    super.key,
    required this.text,
    this.textSize,
    this.svgPath,
    this.fontFamily,
    this.imgPath = "assets/images/tick.png",
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        svgPath == null
            ? Image.asset(
                imgPath,
              )
            : SvgPicture.asset(svgPath!),
        8.pw,
        MyText(
          text,
          fontFamily: fontFamily ?? 'Raleway',
          fontSize: textSize ?? 14,
          height: 1.25,
        ),
      ],
    );
  }
}
