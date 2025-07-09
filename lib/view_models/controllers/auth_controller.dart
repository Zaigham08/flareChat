import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_chat/utils/utils.dart';
import 'package:flare_chat/view/auth/login.dart';
import 'package:get/get.dart';

import '../../view/home.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late Rxn<User> firebaseUser;
  RxBool isLoading = false.obs, hidePassword = true.obs;

  // final GoogleSignIn signIn = GoogleSignIn.instance;

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = cred.user;
      if (user != null) {
        await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
          "uid": user.uid,
          "name": name,
          "email": user.email,
        });
      }
      isLoading.value = false;
      Get.back();
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> login({required String email, required String password}) async {
    try {
      isLoading.value = true;
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      isLoading.value = false;
      Get.offAll(() => const HomePage());
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString());
    }
  }

  void toggleHidePassword() {
    hidePassword.value = !hidePassword.value;
  }

  bool isEmailValid(String email) {
    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    return emailRegex.hasMatch(email);
  }

  Future<void> logout() async {
    Utils.showSimpleLoading();
    await _auth.signOut();
    Utils.dismissLoadingDialog();
    Get.offAll(() => const LoginPage());
  }

  // Future<void> googleSignIn() async {
  //   try {
  //     final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
  //     final GoogleSignInAuthentication gAuth = gUser!.authentication;
  //
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: gAuth.accessToken,
  //       idToken: gAuth.idToken,
  //     );
  //
  //     await _auth.signInWithCredential(credential);
  //   } catch (e) {
  //     Get.snackbar("Error", e.toString());
  //   }
  // }

  //
  // Future<void> initGoogleSignIn() async {
  //
  //   unawaited(
  //     signIn
  //         .initialize(
  //       clientId: null, // Add if you're on iOS/web
  //       serverClientId: null, // Add if you're using backend
  //     )
  //         .then((_) {
  //       signIn.authenticationEvents
  //           .listen(_handleAuthenticationEvent)
  //           .onError(_handleAuthenticationError);
  //
  //       signIn.attemptLightweightAuthentication(); // auto-login silently
  //     }),
  //   );
  // }
  //
  // void _handleAuthenticationEvent(GoogleSignInAuthenticationEvent event) {
  //   final user = event.account;
  //   if (user != null) {
  //     print("User signed in: ${user.displayName}");
  //     // Optionally: use `user.authorizationClient` for scopes or auth tokens
  //   }
  // }
  //
  // void _handleAuthenticationError(Object error) {
  //   print("Google Auth error: $error");
  // }
}
