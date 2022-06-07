
import 'package:my_fina/base/theme.dart';
import 'package:my_fina/helper/spacing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

errorToast({String? title, String? msg}){
  Get.snackbar(title ?? "Oops", msg!, snackPosition: SnackPosition.TOP, margin: EdgeInsets.all(wValue(20)), backgroundColor: Colors.red, colorText: Colors.white);
}

successToast({String? title, String? msg}){
  Get.snackbar(title ?? "Yeah!", msg!, snackPosition: SnackPosition.TOP, margin: EdgeInsets.all(wValue(20)), backgroundColor: colorPrimary, colorText: Colors.white);
}
