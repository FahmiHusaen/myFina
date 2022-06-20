import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_fina/helper/global_helper.dart';
import 'package:my_fina/screens/login/login_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../main/main_screen.dart';

class SplashController extends GetxController {
  var box = GetStorage();

  @override
  void onInit() {
    nextPage();
    super.onInit();
  }

  void nextPage() {
    final user = FirebaseAuth.instance.currentUser;
    var duration = const Duration(seconds: 4);
    Timer(duration, () {
      if (user != null) {
        goToPage(const MainScreen(), context: Get.context!, dismissPage: true);
      } else {
        goToPage(LoginScreen(), context: Get.context!, dismissPage: true);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
