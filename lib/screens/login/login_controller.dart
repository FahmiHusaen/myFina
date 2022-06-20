//import 'package:my_fina/data/api_services.dart';
//import 'package:my_fina/data/endpoint.dart';
//import 'package:my_fina/data/model/response/base_response.dart';
//import 'package:my_fina/data/model/response/login_response.dart';
import 'dart:async';

import 'package:my_fina/helper/global_helper.dart';
import 'package:my_fina/screens/main/main_screen.dart';
//import 'package:my_fina/helper/key_storage.dart';
//import 'package:my_fina/screens/main/main_screen.dart';
//import 'package:my_fina/screens/pasca_register/pasca_register_screen.dart';
//import 'package:my_fina/screens/verifikasi_email/verifikasi_email_screen.dart';
import 'package:my_fina/widget/toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController extends GetxController {
  var box = GetStorage();

  Rx<TextEditingController> phoneTxtController = TextEditingController().obs;
  Rx<TextEditingController> otpTxtController = TextEditingController().obs;

  RxBool isLoading = false.obs;
  RxBool isShowPass = false.obs;

  RxString errorPhone = "".obs;
  RxString errorOtp = "".obs;

  RxInt step = 0.obs;
  RxString currentPhoneNumber = "".obs;

  RxInt resendTime = 60.obs;
  RxInt otpTimeoutDuration = 60.obs;
  RxString currentVerifyCode = "".obs;

  @override
  void onInit() {

    if(kDebugMode){
      phoneTxtController.value.text = "81215747812";
    }

    super.onInit();
  }

  void confirmOtp() async {
    isLoading.value = true;
    String pin = otpTxtController.value.text;
    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
          verificationId: currentVerifyCode.value, smsCode: pin))
          .then((value) async {
        isLoading.value = false;
        if (value.user != null) {
          goToPage(MainScreen(), context: Get.context!, dismissPage: true);
          //successToast(msg: "Login with phone number success");
        }
      });
    } catch (e) {
      isLoading.value = false;
      errorToast(msg: "Invalid OTP");
    }
  }

  login(){
    isLoading.value = true;
    currentPhoneNumber.value = "+62" + phoneTxtController.value.text;
    verifyPhone(currentPhoneNumber.value);
    /*
    if(errorEmail.value == "" && errorPass.value == "" && isEmailValid(emailTxtController.value.text)){
      apiLogin();
    }
     */
  }

  void validating(){
    if(phoneTxtController.value.text.toString().isEmpty){
      errorPhone.value = "Email tidak boleh kosong";
    }else{
      if(!isEmailValid(phoneTxtController.value.text.toString())){
        errorPhone.value = "Email tidak valid";
      }else {
        errorPhone.value = "";
      }
    }

    if(otpTxtController.value.text.toString().isEmpty){
      errorOtp.value = "Password tidak boleh kosong";
    }else{
      errorOtp.value = "";
    }
  }

  void resendOtpTimer() async {
    resendTime.value =  otpTimeoutDuration.value;
    const oneSec = const Duration(seconds: 1);
    Timer.periodic(
      oneSec,
          (Timer timer) {
        if (resendTime == 0) {
          timer.cancel();
        } else {
          resendTime--;
        }
      },
    );
  }

  verifyPhone(String phoneNumber) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            isLoading.value = false;
            if (value.user != null) {
              successToast(msg: "Login success");
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          isLoading.value = false;
          print(e.message);
        },
        codeSent: (String verificationID, int? resendToken) {
          isLoading.value = false;
          currentVerifyCode.value = verificationID;
          successToast(msg: "OTP sent");
          resendOtpTimer();
          if(step.value == 0) {
            step.value++;
          }
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          errorToast(msg: "OTP retrieval timeout");
          currentVerifyCode.value = verificationID;
        },
        timeout: Duration(seconds: otpTimeoutDuration.value));
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
