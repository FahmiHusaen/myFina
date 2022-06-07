import 'package:my_fina/base/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaling/screen_scale_properties.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

loading({Indicator? typeIndicator, Color? color, double? width}){
  return Center(
    child: Container(child: LoadingIndicator(indicatorType: (typeIndicator == null) ? Indicator.ballPulseRise : typeIndicator, color: (color == null) ? colorPrimary : color), width: width ?? ScreenScale.convertWidth(40),) ,
  );
}

loadingDialog({Indicator? typeIndicator, Color? color, double? width, bool? isCancelable}){
  Get.dialog(Center(
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        margin: EdgeInsets.only(left: ScreenScale.convertWidth(20), right: ScreenScale.convertWidth(20), top: ScreenScale.convertWidth(10), bottom: ScreenScale.convertWidth(20)),
        child: LoadingIndicator(indicatorType: (typeIndicator == null) ? Indicator.ballPulseRise : typeIndicator, color: (color == null) ? colorPrimary : color), width: width ?? ScreenScale.convertWidth(40),),
      )
  ), barrierDismissible: isCancelable ?? false,);
}