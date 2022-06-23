
import 'dart:io';

import 'package:my_fina/base/theme.dart';
import 'package:path/path.dart' as path;
import 'package:my_fina/helper/global_helper.dart';
import 'package:my_fina/helper/spacing.dart';
import 'package:my_fina/widget/button.dart';
import 'package:my_fina/widget/edittext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
//oi5
// inokjuknoimport 'package:image_picker/image_picker.dart';
import 'loading.dart';

chooseImageDialog(BuildContext context, {Function? onClick}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(wValue(12))),
          child: Wrap(
            children: [
              Container(
                color: bgPage(),
                padding: EdgeInsets.all(wValue(15)),
                child: Column(
                  children: [
                    InkWell(
                      child: Container(
                        child: Row(
                          children: [
                            Icon(Icons.photo, color: textColor(),),
                            wSpace(10),
                            Text(
                              "Galeri",
                              style: boldTextFont.copyWith(
                                  fontSize: fontSize(14), color: textColor()),
                            )
                          ],
                        ),
                        width: Get.width,
                      ),
                      onTap: () {
                        Get.back();
                        onClick!(1);
                      },
                    ),
                    hSpace(15),
                    InkWell(
                      child: Container(
                        child: Row(
                          children: [
                            Icon(Icons.camera, color: textColor(),),
                            wSpace(10),
                            Text(
                              "Kamera",
                              style: boldTextFont.copyWith(
                                  fontSize: fontSize(14), color: textColor()),
                            )
                          ],
                        ),
                        width: Get.width,
                      ),
                      onTap: () {
                        Get.back();
                        onClick!(2);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      });
}

showConfirmDialog({String? title, String? content, String? btnPos, String? btnNeg, Function? onClickBtnPos, Function? onClickBtnNeg}){
  return showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(wValue(12))),
          child: Wrap(
            children: [
              Container(
                color: bgPage(),
                padding: EdgeInsets.only(top: wValue(15), bottom: wValue(15), left: wValue(25), right: wValue(25)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(title != null) Text(title, style: boldTextFont.copyWith(fontSize: fontSize(16), color: textColor()),),
                    hSpace(10),
                    Text("$content", style: regularTextFont.copyWith(fontSize: fontSize(14), color: textColor()),),
                    hSpace(10),
                    Row(
                      children: [
                        Expanded(child: Button("$btnPos", colorPrimary, true, (){
                          Get.back();
                          onClickBtnPos!();
                        }, height: hValue(40)), flex: 1,),
                        wSpace(10),
                        Expanded(child: ButtonBorder("$btnNeg", colorPrimary,  (){
                          Get.back();
                          onClickBtnNeg!();
                        }, height: hValue(40)), flex: 1,),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      });
}


