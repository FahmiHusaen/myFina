import 'package:flutter/cupertino.dart';
import 'package:flutter_screen_scaling/flutter_screen_scaling.dart';

wSpace(value){
  return SizedBox(width: ScreenScale.convertWidth(value),);
}

hSpace(value){
  return SizedBox(height: ScreenScale.convertHeight(value),);
}

double fontSize(value){
  return ScreenScale.convertFontSize(value);
}

double hValue(value){
  return ScreenScale.convertHeight(value);
}

double wValue(value){
  return ScreenScale.convertWidth(value);
}