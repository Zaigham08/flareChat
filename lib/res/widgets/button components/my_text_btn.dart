import 'package:flare_chat/res/helper_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flare_chat/res/constants.dart';

class MyTextButton extends StatelessWidget {
  final String text;
  final double btnTxtSize, radius, height;
  final double? width;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color buttonColor, textColor;
  final Widget? icon;

  const MyTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height = 45,
    this.buttonColor = btnColor,
    this.isLoading = false,
    this.btnTxtSize = 15,
    this.radius = 8,
    this.icon,
    this.textColor = whiteColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    color: whiteColor,
                    strokeWidth: 3,
                  ),
                )
              : icon != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        12.pw,
                        icon!,
                        Text(
                          text,
                          style: TextStyle(
                            fontSize: btnTxtSize,
                            fontWeight: FontWeight.w600,
                            color: whiteColor,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      text,
                      style: TextStyle(
                        fontSize: btnTxtSize,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
        ),
      ),
    );
  }
}
