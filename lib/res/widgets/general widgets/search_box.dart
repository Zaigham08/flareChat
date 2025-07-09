import 'package:get/get.dart';
import 'package:flare_chat/res/constants.dart';
import 'package:flutter/material.dart';
import 'my_text.dart';

class SearchBox extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged, onSubmitted;
  final VoidCallback onPressed;

  const SearchBox({
    super.key,
    required this.onPressed,
    required this.hintText,
    this.onChanged,
    this.controller,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: whiteColor.withValues(alpha: .8),
            width: .8,
          ),
        ),
        child: TextField(
          textCapitalization: TextCapitalization.sentences,
          controller: controller,
          onSubmitted: onSubmitted,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: 15,
            ),
            border: InputBorder.none,
            suffixIcon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: GestureDetector(
                onTap: onPressed,
                child: Container(
                  width: 72,
                  decoration: BoxDecoration(
                    color: btnColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Center(
                    child: MyText(
                      "Search",
                      color: whiteColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
