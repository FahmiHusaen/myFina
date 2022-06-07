import 'package:my_fina/base/theme.dart';
import 'package:my_fina/helper/spacing.dart';
import 'package:my_fina/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaling/flutter_screen_scaling.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

Button(String title, Color color, bool enable, Function onClick,
    {double? fontSize,
    double? radius,
    Color? fontColor,
    bool? isLoading,
    Widget? leftView,
    Widget? rightView,
    double? height}) {
  return MaterialButton(
      color: color,
      elevation: 0,
      hoverElevation: 0,
      focusElevation: 0,
      highlightElevation: 0,
      disabledElevation: 0,
      splashColor: enable ? Colors.white : color,
      height: (height != null) ? height : ScreenScale.convertHeight(40),
      minWidth: Get.width,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 15),
      ),
      child: isLoading != null && isLoading
          ? Container(
              child: LoadingIndicator(
                  indicatorType: Indicator.ballPulse, color: Colors.white),
              width: ScreenScale.convertWidth(40),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                (leftView != null)
                    ? Container(
                        child: leftView,
                        margin: EdgeInsets.only(
                            right: ScreenScale.convertWidth(10)),
                      )
                    : Container(),
                Text(
                  title,
                  style: boldTextFont.copyWith(
                      fontSize: (fontSize != null)
                          ? fontSize
                          : ScreenScale.convertFontSize(15),
                      color: fontColor ?? Colors.white),
                ),
                (rightView != null)
                    ? Container(
                        child: rightView,
                        margin: EdgeInsets.only(
                            right: ScreenScale.convertWidth(10)),
                      )
                    : Container(),
              ],
            ),
      onPressed: () {
        if (enable) {
          onClick();
        }
      });
}

ButtonBorder(String title, Color? borderColor, Function onClick,
    {double? fontSize,
    double? radius,
    Color? fontColor,
      double? thickBorder,
    bool? isLoading,
      Widget? leftView,
      EdgeInsetsGeometry? marginLeftView,
    double? height}) {

  var isLoad = isLoading ?? false;
  return InkWell(
    child: Container(
      height: height ?? hValue(30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 15),
          border: Border.all(color: borderColor ?? colorPrimary, width: thickBorder ?? 1.0)),
      child: isLoad ? loading() :  Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if(leftView != null) Container(
              child: leftView,
              margin: marginLeftView ?? EdgeInsets.only(right: wValue(15)),
            ),
            if(title != "") Text(
              title,
              style: boldTextFont.copyWith(
                fontSize: fontSize ?? wValue(12),
                color: fontColor ?? colorPrimary,
              ),
            )
          ],
        ),
      ),
    ),
    onTap: () {
      onClick();
    },
  );
}
