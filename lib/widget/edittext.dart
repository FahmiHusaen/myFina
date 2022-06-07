import 'package:my_fina/base/theme.dart';
import 'package:my_fina/helper/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

EditText({String? label, String? errorMsg, double? textSize, bool? obsecureText, String? hintText, TextInputType? textInputType, List<TextInputFormatter>? inputFormatters,
  TextInputAction? textInputAction, String? rightIcon, String? leftIcon, bool? isEnable, bool? isReadOnly, Function? onTap, int? maxLines, EdgeInsetsGeometry? contentPadding,
  Function? onRightIconClicked, Function? onLeftIconClicked, bool? isShadow, Color? leftIconColor, double? radius, Color? borderColor, Color? bgColor, required TextEditingController controller, Function? onSubmit, double? paddingRightIcon, Function? onChange, String? validatorText}){
  return TextFormField(
    controller: controller,
    onTap: (){
      if(onTap != null){
        onTap();
      }
    },
    enabled: isEnable ?? true,
    maxLines: maxLines ?? 1,
    readOnly: isReadOnly ?? false,
    obscureText: obsecureText ?? false,
    keyboardType: textInputType ?? TextInputType.text,
    textInputAction: (textInputAction == null) ? TextInputAction.done : textInputAction,
    inputFormatters: inputFormatters ?? [],
    onChanged: (value){
      if(onChange != null) onChange(value);
    },
    onFieldSubmitted: (_){
      if(onSubmit != null) onSubmit(_);
    },
    style: regularTextFont.copyWith(fontSize: textSize ?? fontSize(14), color: Get.isPlatformDarkMode ? Colors.white :  black3),
    decoration: InputDecoration(
      labelText: label,
      fillColor: bgColor ?? Colors.white,
      filled: true,
      labelStyle: regularTextFont.copyWith(fontSize: textSize ?? fontSize(14), color: Get.isPlatformDarkMode ? Colors.white :  black3),
      hintStyle: regularTextFont.copyWith(fontSize: textSize ?? fontSize(14), color: Get.isPlatformDarkMode ? Colors.white :  black3),
      hintText: hintText ?? "",
      contentPadding: contentPadding ?? EdgeInsets.only(left: wValue(15), right: wValue(15)),
      errorText: errorMsg,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor != null ? borderColor : bgColor != null ? bgColor :  Get.isPlatformDarkMode ? black3 :  Color(0xFFD2D2D3)),
        borderRadius: BorderRadius.circular(wValue(radius ?? 5)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor != null ? borderColor : bgColor != null ? bgColor :  Get.isPlatformDarkMode ? black3 :  Color(0xFFD2D2D3)),
        borderRadius: BorderRadius.circular(wValue(radius ?? 5)),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(wValue(radius ?? 5)),
        borderSide: BorderSide(
          color: borderColor != null ? borderColor : bgColor != null ? bgColor :  Get.isPlatformDarkMode ? black3 :  Color(0xFFD2D2D3),
        ),
      ),
      prefixIconConstraints: BoxConstraints(minWidth: wValue(15), minHeight: 0),
      prefixIcon: leftIcon != null ? Padding(
        padding: EdgeInsetsDirectional.only(start: paddingRightIcon ?? wValue(15), end: wValue(10)),
        child: InkWell(
          child: SvgPicture.asset(leftIcon, color: leftIconColor ?? black3,),
          onTap: (){
            if(onLeftIconClicked != null){
              onLeftIconClicked();
            }
          },
        ),
      ) : const Padding(padding: EdgeInsets.all(0),),
      suffixIcon: rightIcon != null ? Padding(
        padding: EdgeInsetsDirectional.only(start: paddingRightIcon ?? wValue(18), end: wValue(15)),
        child: InkWell(
          child: SvgPicture.asset(rightIcon),
          onTap: (){
            if(onRightIconClicked != null){
              onRightIconClicked();
            }
          },
        ),
      ) : const Padding(padding: EdgeInsets.all(0),),
      suffixIconConstraints: BoxConstraints(minWidth: wValue(15), minHeight: 0),
    ),
  );
}


AccEditText(TextEditingController controller, {bool? isIdPhone, String? hintText, Color? borderColor, List<TextInputFormatter>? inputFormatters, String? label, bool? enable, Widget? icon, TextInputType? textInputType, TextInputAction? textInputAction, bool? isPassword, EdgeInsetsGeometry? contentPadding, String? errorMsg, String? rightIcon, Function? onRightIconClicked, double? paddingRightIcon, Function? onChanged}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if(label != null) Text(label, style: regularTextFont.copyWith(fontSize: fontSize(12), color: borderColor ?? black3),),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(icon != null) Container(
            child: icon,
            margin: EdgeInsets.only(top: hValue(15), right: wValue(20)),
          ),
          if(isIdPhone!=null && isIdPhone)
          Container(child:
          Text("+62", style: regularTextFont.copyWith(fontSize: fontSize(18), color: borderColor ?? black1)),
            padding: EdgeInsets.only(top: hValue(10)),
          ),
          wSpace(10),
          Expanded(child: TextFormField(
            obscureText: isPassword ?? false,
            enabled: enable ?? true,
            textInputAction: textInputAction ?? TextInputAction.next,
            keyboardType: textInputType ?? TextInputType.text,
            inputFormatters: inputFormatters ?? [],
            onChanged: (value){
              onChanged!(value);
            },
            controller: controller,
            style: regularTextFont.copyWith(fontSize: fontSize(18), color: borderColor ?? black3),
            decoration: InputDecoration(
              hintStyle: regularTextFont.copyWith(fontSize: fontSize(18), color: borderColor ?? black3),
              labelStyle: regularTextFont.copyWith(fontSize: fontSize(18), color: borderColor ?? black3),
              hintText: hintText ?? "",
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: borderColor ?? black3),
                borderRadius: BorderRadius.circular(wValue(5)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: borderColor ?? black3),
                borderRadius: BorderRadius.circular(wValue(5)),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: borderColor ?? black3),
                borderRadius: BorderRadius.circular(wValue(5)),
              ),
              contentPadding: contentPadding ?? EdgeInsets.only(left: wValue(0), right: wValue(15)),
              errorText: errorMsg,
              errorStyle: regularTextFont.copyWith(fontSize: fontSize(12), color: Colors.red),
              suffixIcon: rightIcon != null ? Padding(
                padding: EdgeInsetsDirectional.only(start: paddingRightIcon ?? wValue(18), end: wValue(15)),
                child: InkWell(
                  child: SvgPicture.asset(rightIcon),
                  onTap: (){
                    if(onRightIconClicked != null){
                      onRightIconClicked();
                    }
                  },
                ),
              ) : const Padding(padding: EdgeInsets.all(0),),
              suffixIconConstraints: BoxConstraints(minWidth: wValue(15), minHeight: 0),
            ),
          ), flex: 1,)
        ],
      )
    ],
  );
}