import 'package:flutter/services.dart';
import 'package:my_fina/base/theme.dart';
import 'package:my_fina/helper/global_helper.dart';
import 'package:my_fina/helper/spacing.dart';
//import 'package:my_fina/screens/forgot_pass/forgot_pass_screen.dart';
import 'package:my_fina/screens/login/login_controller.dart';
//import 'package:my_fina/screens/register/register_screen.dart';
import 'package:my_fina/widget/button.dart';
import 'package:my_fina/widget/edittext.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {

    return Container(
      color: colorPrimary,
      child: Obx(()=> SafeArea(
        child: Scaffold(
          backgroundColor: bgPage(),
          body: Container(
            width: Get.width,
            height: Get.height,
            child: Center(
                child: (controller.step.value == 0) ? viewPhoneNumber() : viewOTP()
            ),
            padding: EdgeInsets.all(wValue(25)),
          ),
        ),
      )),
    );
  }

  viewPhoneNumber(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hSpace(15),
        hSpace(4),
        Text("Masuk", style: boldTextFont.copyWith(fontSize: fontSize(35), color: Get.isPlatformDarkMode ? Colors.white : black1),),
        hSpace(30),
        AccEditText(controller.phoneTxtController.value, isIdPhone: true, hintText: "Nomor Telefon",
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.phone,
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),],
            icon: Icon(Icons.phone, color: black3,),
            errorMsg: controller.errorPhone.value == "" ? null : controller.errorPhone.value,
            onChanged: (v){
              //controller.validating();
            }),
        hSpace(34),
        Button("Masuk", colorPrimaryDark,  !controller.isLoading.value, (){
          controller.login();
        }, height: hValue(57), isLoading: controller.isLoading.value, fontSize: fontSize(18), radius: wValue(20)),
      ],
    );
  }

  viewOTP(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hSpace(15),
        hSpace(4),
        Text("Verifikasi diri anda", style: boldTextFont.copyWith(fontSize: fontSize(35), color: Get.isPlatformDarkMode ? Colors.white : black1),),
        hSpace(10),
        Center(
          child: RichText(
            text: TextSpan(
                text: 'Mengirim OTP ke ' + controller.currentPhoneNumber.value,
                style: regularTextFont.copyWith(fontSize: fontSize(18), color: black3),
            ),
          ),
        ),
        Center(
          child: RichText(
            text: TextSpan(
                text: 'Ganti nomor telepon',
                style: regularTextFont.copyWith(fontSize: fontSize(18), color: colorPrimary),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                  controller.step.value = 0;
                }
                )
          ),
        ),
        hSpace(10),
        AccEditText(controller.otpTxtController.value, hintText: "Kode OTP",
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.emailAddress,
            icon: SvgPicture.asset("assets/icons/ic_email_at.svg"),
            errorMsg: controller.errorOtp.value == "" ? null : controller.errorOtp.value,
            onChanged: (v){
              //controller.validating();
            }),
        hSpace(34),
        Button("Konfirmasi", colorPrimaryDark,  !controller.isLoading.value, (){
          controller.confirmOtp();
        }, height: hValue(57), isLoading: controller.isLoading.value, fontSize: fontSize(18), radius: wValue(20)),
        hSpace(34),
        Center(
          child: RichText(
            text: TextSpan(
              text: 'Belum menerima kode OTP?',
              style: regularTextFont.copyWith(fontSize: fontSize(18), color: black3),
            ),
          ),
        ),
        Center(
          child: RichText(
              text: TextSpan(
                  text: (controller.resendTime.value > 0) ? controller.resendTime.value.toString() : 'Kirim ulang',
                  style: regularTextFont.copyWith(fontSize: fontSize(18), color: colorPrimary),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      if(controller.resendTime.value == 0){
                        controller.login();
                      }
                    }
              )
          ),
        ),
        hSpace(10),
      ],
    );
  }
}
