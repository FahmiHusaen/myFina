import 'dart:convert';
//import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_fina/screens/login/login_screen.dart';
import 'package:my_fina/widget/toast.dart';

class LanguageListController extends GetxController {
  RxBool isLoading = false.obs;

  RxBool isNowIndo = false.obs;
  RxBool isNowEng = false.obs;

  var box = GetStorage();
  Locale? locale;

  Locale localeIndo = Locale('id', 'ID');
  Locale localeEng = Locale('en', 'US');

  initController() async {
    getCurrentLocale();
  }

  updateLocale(Locale locale) {
    Get.updateLocale(locale);
    updateStatus(locale);
    box.write("KEY_LANG", locale.languageCode);
    box.write("KEY_COUN", locale.countryCode);
  }

  updateStatus(Locale locale){
    if(locale == localeIndo){
      isNowIndo.value = true;
      isNowEng.value = false;
    }
    if(locale == localeEng){
      isNowEng.value = true;
      isNowIndo.value = false;
    }
  }

  getCurrentLocale(){
    if(box.read("KEY_LANG") != null && box.read("KEY_COUN") != null){
      try {
        locale = Locale(box.read("KEY_LANG").toString(), box.read("KEY_COUN").toString());
        updateStatus(locale!);
      } catch (_) {
        errorToast(msg: "Get current language error");
      }
    } else {
      errorToast(msg: "Get current language error");
    }
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
