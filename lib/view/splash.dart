import 'package:flare_chat/res/constants.dart';
import 'package:flare_chat/res/widgets/general%20widgets/my_text.dart';
import 'package:flutter/material.dart';

import '../view_models/services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashServices = SplashServices();

  @override
  void initState() {
    splashServices.isUserLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MyText("FlareChat", color: primaryColor, fontSize: 28),
      ),
    );
  }
}
