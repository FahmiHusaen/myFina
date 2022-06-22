import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_fina/screens/login/login_screen.dart';
import 'package:my_fina/widget/toast.dart';

class ConfigurationController extends GetxController {
  RxBool isLoading = false.obs;

  initController() async {

  }

  logOut() {
    _signOut();
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut().then((value) {
      Get.offAll(LoginScreen());
    }).catchError((error){
      errorToast(msg: "Kesalahan : " + error.toString());
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
