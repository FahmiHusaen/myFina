import 'package:my_fina/base/theme.dart';
import 'package:my_fina/helper/spacing.dart';
import 'package:my_fina/screens/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(SplashController());

    print("is dark mode => ${Get.isPlatformDarkMode}");

    return Container(
      color: colorPrimary,
      child: Scaffold(
        backgroundColor: bgPage(),
        body: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Center(
            child: Image.asset("assets/img/img_logo_blue.png", width : wValue(233)),
          ),
        ),
      ),
    );
  }
}
