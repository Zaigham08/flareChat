import 'package:flutter/material.dart';
import 'package:flare_chat/res/constants.dart';

import 'my_container.dart';
import 'my_text.dart';

class MyRadioButton extends StatelessWidget {
  final String gender, groupValue;
  final Function(String?)? onChanged;

  const MyRadioButton({
    super.key,
    required this.gender,
    required this.groupValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onChanged != null) onChanged!(gender);
      },
      child: MyContainer(
        height: 45,
        width: 390,
        radius: 5,
        margin: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Radio.adaptive(
              activeColor: btnColor,
              value: gender,
              groupValue: groupValue,
              onChanged: onChanged,
            ),
            MyText(gender, fontSize: 16, fontWeight: FontWeight.w500),
          ],
        ),
      ),
    );
  }
}
