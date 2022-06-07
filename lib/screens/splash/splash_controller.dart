import 'dart:async';
import 'package:my_fina/helper/global_helper.dart';
import 'package:my_fina/screens/login/login_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  var box = GetStorage();

  @override
  void onInit() {
    nextPage();
    super.onInit();
  }

  void nextPage() {
    var duration = const Duration(seconds: 4);
    Timer(duration, () {
      goToPage(LoginScreen(), context: Get.context!, dismissPage: true);
      // goToPage(const PascaRegisterScreen(), context: Get.context!, dismissPage: true);
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
