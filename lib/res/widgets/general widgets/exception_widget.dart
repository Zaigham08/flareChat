import 'package:flutter/material.dart';
import 'package:flare_chat/res/helper_extensions.dart';

import '../../constants.dart';
import '../button components/my_text_btn.dart';

class ExceptionWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double? iconSize, textSize, btnHeight;

  const ExceptionWidget({
    super.key,
    required this.onPressed,
    required this.text,
    this.iconSize,
    this.textSize,
    this.btnHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.cloud_off,
            color: whiteColor.withValues(alpha: .6),
            size: iconSize ?? 55,
          ),
          5.ph,
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: textSize ?? 17.5,
              fontWeight: FontWeight.w600,
              color: whiteColor.withValues(alpha: .6),
            ),
          ),
          10.ph,
          MyTextButton(
            text: "Retry",
            onPressed: onPressed,
            width: 100,
            height: btnHeight ?? 47,
          ),
        ],
      ),
    );
  }
}
