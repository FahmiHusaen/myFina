import 'package:my_fina/base/theme.dart';
import 'package:my_fina/helper/global_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_fina/helper/spacing.dart';
import 'package:my_fina/screens/category_list/category_list_screen.dart';
import 'package:my_fina/screens/language_list/language_list_screen.dart';
import 'package:my_fina/screens/main/history/history_controller.dart';
import 'package:my_fina/widget/button.dart';
import 'package:my_fina/widget/dialog.dart';
import 'package:simple_shadow/simple_shadow.dart';

import 'configuration_controller.dart';

class ConfigurationScreen extends StatefulWidget {
  const ConfigurationScreen({Key? key}) : super(key: key);

  @override
  _ConfigurationScreenState createState() => _ConfigurationScreenState();
}

class _ConfigurationScreenState extends State<ConfigurationScreen> {

  var controller = ConfigurationController();

  @override
  void initState() {
    //controller.initController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      color: bgPage(),
      child:
      //Obx(()=>
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
                  child: Text('conf_title'.tr, style: boldTextFont.copyWith(fontSize: fontSize(27),
                      color:  Get.isPlatformDarkMode ? Colors.white : black1),),
                ), flex: 1,),
              ],
            ),
            hSpace(29),
            itemButton('category_list'.tr, action: (){goToPage(CategoryListScreen(), context: context);}),
            itemButton('language'.tr, action: (){goToPage(LanguageListScreen(), context: context);}),
            hSpace(15),
            Container(
              child: ButtonBorder('logout_btn'.tr, Get.isPlatformDarkMode ? colorPrimary : Colors.grey, (){
                showConfirmDialog(title: 'account_logout'.tr, content: 'are_you_sure_logout'.tr, btnPos: 'yes_btn'.tr,
                    btnNeg: 'cancel_btn'.tr, onClickBtnPos: (){
                      controller.logOut();
                    }, onClickBtnNeg: (){});
              }, radius: wValue(25),  height: hValue(50), fontSize: fontSize(16), fontColor: colorPrimary),
              width: Get.width,
            ),
            ],
        ),
        padding: EdgeInsets.only(bottom: hValue(85), left: wValue(25), right: wValue(25)),
      )
      //),
    );
  }


  itemButton(String title, {Function? action}){
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
            InkWell(
              child: Icon(Icons.navigate_next, size: wValue(17), color: black1),
              onTap: (){
                //dialogAboutFacility(context: Get.context!, data: item);
              },
            ),
            // MeTooltip(
            //   child: SvgPicture.asset("assets/icons/ic_info.svg", width: wValue(17),),
            //   message: "${item.facility_type_desc}",
            //   preferOri: PreferOrientation.down,
            //   padding: EdgeInsets.all(wValue(13)),
            //   decoration: BoxDecoration(
            //     color: colorPrimary,
            //     borderRadius: BorderRadius.circular(10.0),
            //   ),
            // ),
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

