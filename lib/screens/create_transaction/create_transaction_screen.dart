import 'dart:io';

import 'package:my_fina/base/theme.dart';
import 'package:my_fina/helper/global_helper.dart';
import 'package:my_fina/helper/spacing.dart';
import 'package:my_fina/model/category_model.dart';
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

import 'create_transaction_controller.dart';

class CreateTransactionScreen extends StatefulWidget {
  const CreateTransactionScreen({Key? key}) : super(key: key);

  @override
  _CreateTransactionScreenState createState() => _CreateTransactionScreenState();
}

class _CreateTransactionScreenState extends State<CreateTransactionScreen> {

  var controller = CreateTransactionController();
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
                child: (controller.step.value == 0) ? viewToogle() : viewCreate(),
              ),
            )),
          ),
        ),
        onWillPop: onWillPop,
      ),
    );
  }

  viewCreate(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        hSpace(45),
        Container(
          child: Text(controller.isIncome.value ? 'create_transaction_title'.tr + " " + 'income_btn'.tr + '.' : 'create_transaction_title'.tr + " " + 'outcome_btn'.tr + '.',
            style: boldTextFont.copyWith(fontSize: fontSize(27),
              color:  Get.isPlatformDarkMode ? Colors.white : black1),),
          //margin: EdgeInsets.only(right: wValue(15)),
          width: Get.width,
        ),
        hSpace(20),

        //hSpace(29),

        //Text("${controller.user.value.full_name}", style: boldTextFont.copyWith(fontSize: fontSize(17), color: textColor()),),
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

              Text('name_transaction_form'.tr, style: regularTextFont.copyWith(fontSize: fontSize(14), color: textColor()),),
              hSpace(5),
              EditText(controller: controller.nameTxtCtrl.value, textSize: fontSize(14),
                borderColor: Get.isPlatformDarkMode ? Colors.white : black3,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.text,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s")),],
                radius: wValue(25),
                errorMsg: controller.errorName.value.isEmpty ? null : controller.errorName.value,
                onChange: (v){
                  controller.validatingName();
                },
                bgColor: Get.isPlatformDarkMode ? const Color(0xFF404040) : const Color(0xFFF9F9F9),),

              hSpace(20),
              Text('category_form'.tr, style: regularTextFont.copyWith(fontSize: fontSize(14), color: textColor()),),
              hSpace(5),
              DropdownSpinner(
                bgColor: const Color(0xFFF9F9F9),
                items: controller.categoryList.value.map<DropdownMenuItem<CategoryModel>>(
                        (CategoryModel value){
                      return DropdownMenuItem<CategoryModel>(
                        value: value,
                        child: Text(value.name!),
                      );
                    }
                ).toList(),
                value: controller.selectedCategory,
                onChange: (value){
                  setState(() {
                    controller.selectedCategory = value;
                  });
                },
              ),

              hSpace(20),
              Text('amount_form'.tr, style: regularTextFont.copyWith(fontSize: fontSize(14), color: textColor()),),
              hSpace(5),
              EditText(controller: controller.amountTxtCtrl.value, textSize: fontSize(14),
                  borderColor: Get.isPlatformDarkMode ? Colors.white : black3,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),],
                  errorMsg: controller.errorAmount.value.isEmpty ? null : controller.errorAmount.value,
                  radius: wValue(25), bgColor: Get.isPlatformDarkMode ? const Color(0xFF404040) : const Color(0xFFF9F9F9),
                  onChange: (v){
                    controller.validatingAmount();
                  }),

              hSpace(20),
              Text('desc_form'.tr, style: regularTextFont.copyWith(fontSize: fontSize(14), color: textColor()),),
              hSpace(5),
              EditText(controller: controller.descTxtCtrl.value, textSize: fontSize(14),
                borderColor: Get.isPlatformDarkMode ? Colors.white : black3,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.text,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s")),],
                // inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),],
                errorMsg: controller.errorDesc.value.isEmpty ? null : controller.errorDesc.value,
                radius: wValue(25), bgColor: Get.isPlatformDarkMode ? const Color(0xFF404040) : const Color(0xFFF9F9F9),
              ),

              /*
              hSpace(20),
              Text("Foto Bukti Transaksi", style: regularTextFont.copyWith(fontSize: fontSize(14), color: textColor()),),
              hSpace(5),
              Container(
                child: Stack(
                  children: [
                    imgBill(controller.selectedPhoto.value.path, MediaQuery.of(context).size.width, hValue(123)),
                    Positioned(child: InkWell(
                      child: (controller.selectedPhoto.value.path == "") ? Icon(Icons.camera_alt) : Icon(Icons.flip_camera_ios_outlined),
                      onTap: (){
                        chooseImageDialog(context, onClick: (type) async {
                          XFile? image;
                          if(type == 1){
                            image = await _picker.pickImage(source: ImageSource.gallery);
                          }else{
                            image = await _picker.pickImage(source: ImageSource.camera);
                          }

                          cropImage(path: image!.path).then((value)  {
                            String newPath = value.path.replaceAll(path.basename(value.path), "compress_${path.basename(value.path)}");
                            compressFile(File(value.path), newPath, quality: 30).then((img){
                              controller.selectedPhoto.value = img!;
                              //controller.apiChangePhoto(img.path, path.basename(img.path));
                            });
                          });
                        });
                      },
                    ), right: 10, bottom: 10,)
                  ],
                ),
                //width: wValue(123),
                height: wValue(123),
              ),

               */

              // hSpace(20),
              // Text("Alamat Lengkap", style: regularTextFont.copyWith(fontSize: fontSize(14), color: textColor()),),
              // hSpace(5),
              // EditText(controller: controller.addressTxtCtrl.value, textSize: fontSize(14),  radius: wValue(25), borderColor: Get.isPlatformDarkMode ? Colors.white : black3,  bgColor: Get.isPlatformDarkMode ? const Color(0xFF404040) : const Color(0xFFF9F9F9),)
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
              Expanded(child: ButtonBorder('cancel_btn'.tr, Get.isPlatformDarkMode ? colorPrimary : Colors.grey, (){
                controller.step.value = 0;
              }, radius: wValue(25),  height: hValue(40), fontSize: fontSize(16), fontColor: colorPrimary), flex: 1,),
              wSpace(10),
              Expanded(child: Button('save_btn'.tr, colorPrimary, true, (){
                //controller.editProfile();
                controller.sendNewData();
              },  height: hValue(40),), flex: 1,)
            ],
          ),
          margin: EdgeInsets.only(left: wValue(10), right: wValue(10)),
        ),
        hSpace(15),
      ],
    );
  }

  viewToogle(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        hSpace(45),
        Container(
          child: Text('create_transaction_title'.tr + '.', style: boldTextFont.copyWith(fontSize: fontSize(27),
              color:  Get.isPlatformDarkMode ? Colors.white : black1),),
          //margin: EdgeInsets.only(right: wValue(15)),
          width: Get.width,
        ),
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
              Container(
                child: Row(
                  children: [
                    Expanded(child: Button('outcome_btn'.tr + ' --', Colors.red, true, (){
                      controller.step.value = 1;
                      controller.isIncome.value = false;
                      controller.initCategory();
                    },  height: hValue(40),), flex: 1,)
                  ],
                ),
                margin: EdgeInsets.only(left: wValue(10), right: wValue(10)),
              ),
              hSpace(15),
              Container(
                child: Row(
                  children: [
                    Expanded(child: Button('income_btn'.tr + '++', Colors.green, true, (){
                      controller.step.value = 1;
                      controller.isIncome.value = true;
                      controller.initCategory();
                    },  height: hValue(40),), flex: 1,)
                  ],
                ),
                margin: EdgeInsets.only(left: wValue(10), right: wValue(10)),
              ),
              hSpace(15),
              Container(
                child: Row(
                  children: [
                    Expanded(child: ButtonBorder('cancel_btn'.tr, Get.isPlatformDarkMode ? colorPrimary : Colors.grey, (){
                      onWillPop();
                    }, radius: wValue(25),  height: hValue(40), fontSize: fontSize(16), fontColor: colorPrimary), flex: 1,),
                    wSpace(10),
                    Expanded(child: Container(), flex: 1,)
                  ],
                ),
                margin: EdgeInsets.only(left: wValue(10), right: wValue(10)),
              ),
            ],
          ),
        ),
          opacity: 0.6,         // Default: 0.5
          color: Colors.black.withAlpha(50),   // Default: Black
          offset: const Offset(5, 5), // Default: Offset(2, 2)
          sigma: 7,),
      ],
    );
  }

  Future<bool> onWillPop() async {
    Navigator.pop(context, true);

    return true;
  }
}
