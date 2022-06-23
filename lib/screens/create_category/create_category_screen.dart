import 'dart:io';

import 'package:my_fina/base/theme.dart';
import 'package:my_fina/helper/global_helper.dart';
import 'package:my_fina/helper/spacing.dart';
import 'package:my_fina/model/category_model.dart';
import 'package:my_fina/screens/create_category/create_category_controller.dart';
import 'package:my_fina/widget/button.dart';
import 'package:my_fina/widget/dialog.dart';
import 'package:my_fina/widget/dropdown.dart';
import 'package:my_fina/widget/edittext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:path/path.dart' as path;

class CreateCategoryScreen extends StatefulWidget {
  const CreateCategoryScreen({Key? key}) : super(key: key);

  @override
  _CreateCategoryScreenState createState() => _CreateCategoryScreenState();
}

class _CreateCategoryScreenState extends State<CreateCategoryScreen> {

  var controller = CreateCategoryController();
  //final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    controller.initController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorPrimary,
      width: Get.width,
      child: WillPopScope(
        child: SafeArea(
          child: Scaffold(
            backgroundColor: bgPage(),
            body: Obx(()=> SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(bottom: hValue(85), left: wValue(25), right: wValue(25)),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  hSpace(45),
                  Container(
                    child: Text("Buat Kategori.",
                      style: boldTextFont.copyWith(fontSize: fontSize(27),
                          color:  Get.isPlatformDarkMode ? Colors.white : black1),),
                    //margin: EdgeInsets.only(right: wValue(15)),
                    width: Get.width,
                  ),
                  //hSpace(20),
                  hSpace(29),
                  SimpleShadow(child: Container(
                    //margin: EdgeInsets.only(left: wValue(15), right: wValue(15)),
                    decoration:  BoxDecoration(
                      color: Get.isPlatformDarkMode ? Color(0xFF404040) : Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    padding: EdgeInsets.all(wValue(25)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Nama Kategori", style: regularTextFont.copyWith(fontSize: fontSize(14), color: textColor()),),
                        hSpace(5),
                        EditText(controller: controller.categoryTxtCtrl.value, textSize: fontSize(14),
                          borderColor: Get.isPlatformDarkMode ? Colors.white : black3,
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.text,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s")),],
                          // inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),],
                          errorMsg: controller.errorCategory.value.isEmpty ? null : controller.errorCategory.value,
                          radius: wValue(25), bgColor: Get.isPlatformDarkMode ? const Color(0xFF404040) : const Color(0xFFF9F9F9),
                        ),
                      ],
                    ),
                  ),
                    opacity: 0.6,         // Default: 0.5
                    color: Colors.black.withAlpha(50),   // Default: Black
                    offset: const Offset(5, 5), // Default: Offset(2, 2)
                    sigma: 7,),

                  hSpace(15),
                  Container(
                    child: Row(
                      children: [
                        Expanded(child: ButtonBorder("Batal", Get.isPlatformDarkMode ? colorPrimary : Colors.grey, (){
                          onWillPop();
                        }, radius: wValue(25),  height: hValue(40), fontSize: fontSize(16), fontColor: colorPrimary), flex: 1,),
                        wSpace(10),
                        Expanded(child: Button("Simpan", colorPrimary, true, (){
                          controller.sendNewData();
                          onWillPop();
                        },  height: hValue(40),), flex: 1,)
                      ],
                    ),
                    margin: EdgeInsets.only(left: wValue(10), right: wValue(10)),
                  ),
                  hSpace(15),
                ],
              ),
              ),
            )),
          ),
        ),
        onWillPop: onWillPop,
      ),
    );
  }

  Future<bool> onWillPop() async {
    Navigator.pop(context, true);

    return true;
  }
}
