import 'package:flare_chat/res/constants.dart';
import 'package:flare_chat/res/helper_extensions.dart';
import 'package:flutter/material.dart';

class IconTextBtn extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? color;
  final String btnText;
  final IconData icon;

  const IconTextBtn({
    super.key,
    required this.onPressed,
    this.color,
    required this.btnText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 50,
        width: 178,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: whiteColor,
            ),
            10.pw,
            Text(
              btnText,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
