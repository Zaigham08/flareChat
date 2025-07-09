import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_chat/view/auth/login.dart';
import 'package:flare_chat/view/home.dart';
import 'package:get/get.dart';

class SplashServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> isUserLoggedIn() async {
    if (_auth.currentUser == null) {
      await Future.delayed(const Duration(milliseconds: 1500));
      Get.offAll(() => const LoginPage());
    } else {
      await Future.delayed(
        const Duration(milliseconds: 1500),
        () => Get.offAll(() => const HomePage()),
      );
    }
  }
}
