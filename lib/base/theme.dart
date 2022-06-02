import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Color colorPrimary = const Color(0xFF01ABC6);
Color colorPrimaryDark = const Color(0xFF01ABC6);
Color colorAccentDark = const Color(0xFF0D47A1);
Color line = const Color(0xFFEFEAEA);
Color dark = const Color(0xFF212121);
Color darkBright = const Color(0xFF404040);

Color bgPage({Color? darkColor, Color? lightColor}){
  if(Get.isPlatformDarkMode){
    return darkColor ?? dark;
  }else{
    return lightColor ?? Colors.white;
  }
}

Color textColor({Color? darkColor, Color? lightColor}){
  if(Get.isPlatformDarkMode) {
    return darkColor ?? Colors.white;
  } else {
    return lightColor ?? Colors.black;
  }
}

Color yellow1 = const Color(0xFFFFB407);
Color yellow2 = const Color(0xFFFFDA33);
Color yellow4 = const Color(0xFFFFF8D6);

Color blue1 = const Color(0xFF0D45D3);
Color blue5 = const Color(0xFFECF1FE);
Color blue6 = const Color(0xFFF0F2F6);

Color red1 = const Color(0xFFFF4B4B);
Color red2 = const Color(0xFFFFE8E8);
Color red3 = const Color(0xFFFFF8F8);

Color black1 = const Color(0xFF2A2E33);
Color black2 = const Color(0xFF474747);
Color black3 = const Color(0xFF969696);
Color black4 = const Color(0xFFB4B4B4);
Color black5 = const Color(0xFFE0E0E0);
Color black6 = const Color(0xFFD7DEEA);
Color black7 = const Color(0xFFF4F4F4);

Color green1 = const Color(0xFF00BB1D);
Color green2 = const Color(0xFFEBFFEE);

Color linkColor = const Color(0xFF1976D2);
Color gold = const Color(0xFFBF8704);

Color greyShimmer = const Color(0xffE7E7E7);

TextStyle boldTextFont = GoogleFonts.poppins().copyWith(color: Colors.black, fontWeight: FontWeight.w800);
TextStyle regularTextFont = GoogleFonts.poppins().copyWith(color: Colors.black);

