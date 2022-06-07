//import 'package:my_fina/data/api_services.dart';
//import 'package:my_fina/data/endpoint.dart';
//import 'package:my_fina/data/model/response/base_response.dart';
//import 'package:my_fina/data/model/response/login_response.dart';
import 'package:my_fina/helper/global_helper.dart';
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

  @override
  void onInit() {

    if(kDebugMode){
      phoneTxtController.value.text = "81215747812";
      otpTxtController.value.text = "masukaja";
    }

    super.onInit();
  }

  login(){
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

  void apiLogin() async {
    isLoading.value = true;
  }


  verifyPhone(String phoneNumber) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              successToast(msg: "Login success");
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, int? resendToken) {
          successToast(msg: "OTP sent");
          if(step.value == 0) {
            step.value++;
          }
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          errorToast(msg: "OTP retrieval timeout");
        },
        timeout: Duration(seconds: 120));
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
