import 'package:my_fina/base/theme.dart';
import 'package:my_fina/helper/global_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_fina/helper/spacing.dart';
import 'package:my_fina/screens/category_list/category_list_screen.dart';
import 'package:my_fina/screens/main/history/history_controller.dart';
import 'package:my_fina/widget/button.dart';
import 'package:my_fina/widget/dialog.dart';
import 'package:simple_shadow/simple_shadow.dart';

import 'language_list_controller.dart';

class LanguageListScreen extends StatefulWidget {
  const LanguageListScreen({Key? key}) : super(key: key);

  @override
  _LanguageListScreenState createState() => _LanguageListScreenState();
}

class _LanguageListScreenState extends State<LanguageListScreen> {

  var controller = LanguageListController();

  @override
  void initState() {
    //controller.initController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: onWillPop,
        child: Container(
          width: Get.width,
          color: bgPage(),
          child:
          Obx(()=>
              Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                hSpace(45),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: Container(
                      margin: EdgeInsets.only(right: wValue(15)),
                      child: Text('language_title'.tr + '.', style: boldTextFont.copyWith(fontSize: fontSize(27),
                          color:  Get.isPlatformDarkMode ? Colors.white : black1),),
                    ), flex: 1,),
                  ],
                ),
                hSpace(29),
                itemButton('eng_language'.tr, controller.isNowEng.value,
                    action: (){
                  controller.updateLocale(controller.localeEng);
                }),
                itemButton('indonesia_language'.tr, controller.isNowIndo.value,
                    action: (){
                  controller.updateLocale(controller.localeIndo);
                    }
                ),
                hSpace(29),
                Container(
                  child: ButtonBorder('back_btn'.tr, Get.isPlatformDarkMode ? colorPrimary : Colors.grey, (){
                    onWillPop();
                  }, radius: wValue(25),  height: hValue(50), fontSize: fontSize(16), fontColor: colorPrimary),
                  width: Get.width,
                ),
                ],
            ),
            padding: EdgeInsets.only(bottom: hValue(85), left: wValue(25), right: wValue(25)),
          )
          ),
        ),
      ),
    );
  }


  Future<bool> onWillPop() async {
    Navigator.pop(context, true);

    return true;
  }

  itemButton(String title, bool selected, {Function? action}){
    return InkWell(
        child: SimpleShadow(child: Container(
          decoration: BoxDecoration(
            color: Get.isPlatformDarkMode ? darkBright : Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          margin: EdgeInsets.only(bottom: hValue(10)),
          padding: EdgeInsets.all(wValue(10)),
          child: Row(
            children: [
              Expanded(child: Text(title, style: boldTextFont.copyWith(fontSize: fontSize(17), color: textColor()),), flex: 1,),
              wSpace(10),
              Icon(selected ? Icons.check_circle : Icons.radio_button_unchecked_sharp, size: wValue(17), color: black1),
            ],
          ),
        ),
          opacity: 0.3,
          color: Colors.black.withAlpha(80),
          offset: const Offset(-2, 3),
          sigma: 5,
        ),
        onTap: (){
          if(action != null){
            action();
          }
        },
      );
  }
}

