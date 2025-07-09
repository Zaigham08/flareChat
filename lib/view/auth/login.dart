import 'package:flare_chat/res/constants.dart';
import 'package:flare_chat/res/helper_extensions.dart';
import 'package:flare_chat/res/widgets/button%20components/my_text_btn.dart';
import 'package:flare_chat/res/widgets/general%20widgets/rich_texts_link.dart';
import 'package:flare_chat/res/widgets/input%20field%20components/my_text_input_field.dart';
import 'package:flare_chat/utils/utils.dart';
import 'package:flare_chat/view/auth/register.dart';
import 'package:flare_chat/view_models/controllers/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/widgets/appBar components/my_appbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final authController = Get.find<AuthController>();
    return Scaffold(
      appBar: myAppBar("login"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            children: [
              30.ph,
              Form(
                key: formKey,
                child: Column(
                  children: [
                    MyTextInputField(
                      hintText: "Email",
                      width: 390,
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      keyboardType: TextInputType.emailAddress,
                      textCapitalization: TextCapitalization.none,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Required*";
                        } else if (!authController.isEmailValid(value)) {
                          return 'Email Address is not valid';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) {
                        Utils.fieldFocusChange(
                          context,
                          _emailFocusNode,
                          _passwordFocusNode,
                        );
                      },
                    ),
                    6.ph,
                    Obx(
                          () =>
                          MyTextInputField(
                            hintText: "Enter password",
                            width: 390,
                            controller: _passwordController,
                            focusNode: _passwordFocusNode,
                            hidePassword: authController.hidePassword.value,
                            textCapitalization: TextCapitalization.none,
                            maxLines: 1,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Required*";
                              }
                              return null;
                            },
                            onFieldSubmitted: (_) {
                              if (formKey.currentState!.validate()) {
                                authController.login(
                                  email: _emailController.text.trim()
                                      .toString(),
                                  password:
                                  _passwordController.text.trim().toString(),
                                );
                              }
                            },
                            widget: GestureDetector(
                              onTap: () => authController.toggleHidePassword(),
                              child: Icon(
                                CupertinoIcons.eye_slash,
                                color: dimColor,
                                size: 20,
                              ),
                            ),
                          ),
                    ),
                  ],
                ),
              ),
              25.ph,
              Obx(
                    () =>
                    MyTextButton(
                      text: "Login",
                      width: 390,
                      isLoading: authController.isLoading.value,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          authController.login(
                            email: _emailController.text.trim().toString(),
                            password: _passwordController.text.trim()
                                .toString(),
                          );
                        }
                      },
                    ),
              ),
              40.ph,
              MyRichTextsLink(
                text1: "Don't have an account? ",
                text2: "Register",
                onPressed: () {
                  Get.to(
                        () => const RegisterPage(),
                    transition: Transition.downToUp,
                    duration: const Duration(milliseconds: 800),
                  );
                },
              ),
              20.ph,
            ],
          ),
        ),
      ),
    );
  }
}
