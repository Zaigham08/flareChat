import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flare_chat/res/constants.dart';
import 'package:flare_chat/res/helper_extensions.dart';

import 'my_container.dart';
import 'my_text.dart';

GestureDetector selectImageBox(var controller) {
  return GestureDetector(
    onTap: () => controller.takePictureFromGallery(),
    child: Obx(
      () => MyContainer(
        radius: 10,
        width: double.infinity,
        child: controller.imgPath.value.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const MyText(
                      "Select Image",
                      fontSize: 16,
                      color: iconColor,
                      fontWeight: FontWeight.bold,
                    ),
                    5.ph,
                    SvgPicture.asset(
                      "assets/svgs/upload.svg",
                      height: 32,
                    )
                  ],
                ),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: InteractiveViewer(
                  minScale: 0.1,
                  maxScale: 2.0,
                  child: Image.file(
                    File(controller.imgPath.value),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
      ),
    ),
  );
}
