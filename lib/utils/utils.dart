import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flare_chat/res/helper_extensions.dart';
import 'package:flare_chat/res/widgets/general%20widgets/my_spinkit_fading_circle.dart';
import 'package:flare_chat/res/widgets/general%20widgets/my_text.dart';

import '../res/constants.dart';

class Utils {
  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static snackBar(String title, String message, {Color? color}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: color ?? toastColor,
      colorText: whiteColor,
      duration: const Duration(seconds: 4),
    );
  }

  static toastMsg(String message, {Color color = toastColor}) {
    Fluttertoast.showToast(
      msg: message,
      textColor: whiteColor,
      backgroundColor: color,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  static showLoadingDialog(String message) {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        backgroundColor: textFieldColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: SizedBox(
          width: 260,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const MySpinKitFadingCircle(
                  size: 60,
                  color: btnColor,
                ),
                8.ph,
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 17.5,
                    color: txtColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static showSimpleLoading({bool canPop = true}) {
    Get.dialog(
      barrierDismissible: false,
      PopScope(
        canPop: canPop,
        child: const Center(
          child: MySpinKitFadingCircle(
            size: 60,
            color: btnColor,
          ),
        ),
      ),
    );
  }

  static void dismissLoadingDialog() {
    if (Get.isDialogOpen!) {
      Get.back(); // Close the loading dialog
    }
  }

  static showConfirmationDialog({
    required String title,
    required String text,
    required String btnText,
    required VoidCallback onTap,
  }) {
    Get.dialog(
      Dialog(
        backgroundColor: textFieldColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: SizedBox(
          width: 320,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 17,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                10.ph,
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                5.ph,
                Divider(color: dividerColor),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DialogTextButton(
                      text: "Cancel",
                      color: blueColor,
                      onTap: () => Get.back(),
                    ),
                    10.pw,
                    DialogTextButton(
                      text: btnText,
                      color: btnColor,
                      onTap: onTap,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}

class DialogTextButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onTap;

  const DialogTextButton({
    super.key,
    required this.text,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MyText(
        text,
        fontSize: 17,
        fontFamily: "Poppins",
        color: color,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
