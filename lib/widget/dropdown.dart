import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:my_fina/helper/spacing.dart';

import '../base/theme.dart';

DropdownSpinner({required List<DropdownMenuItem<dynamic>> items, dynamic? value, Function? onChange, Color? bgColor, double? textSize, double? radius}){
  return DropdownButton<dynamic>(
      items: items,
      onChanged: (value){
        if(onChange != null) onChange(value);
      },
    style: regularTextFont.copyWith(fontSize: textSize ?? fontSize(14), color: black3),
    borderRadius: BorderRadius.circular(wValue(radius ?? 5)),
    dropdownColor: bgColor ?? Colors.white,
    elevation: 0,
    value: value,
    isExpanded: true,
    underline: Container(),
  );
}