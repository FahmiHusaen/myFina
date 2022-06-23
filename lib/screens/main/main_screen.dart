import 'package:my_fina/base/theme.dart';
import 'package:my_fina/helper/spacing.dart';
import 'package:my_fina/screens/main/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    MainController controller = Get.put(MainController());

    return Container(
      color: colorPrimary,
      child: SafeArea(
        child: Obx(() => Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            child: Stack(
              children: [
                controller.setCurrentPage(index: controller.currentIndex.value),
                Positioned(
                  child: tabBottom(),
                  bottom: 0,
                ),
              ],
            ),
            width: Get.width,
            height: Get.height,
          ),
        )),
      ),
    );
  }

  tabBottom(){
    MainController controller = Get.find();

    return Container(
      padding: EdgeInsets.only(left: wValue(15), right: wValue(15), bottom: wValue(10), top: wValue(15)),
      width: Get.width,
      decoration: BoxDecoration(
        color: Get.isPlatformDarkMode ? Colors.black : colorPrimary,
      ),
      child: Row(
        children: [
          itemHome('history_btn'.tr, Icon(Icons.history_rounded, size: 25, color: Colors.white,), Icon(Icons.history_toggle_off, size: 25, color: Colors.white,), controller.currentIndex.value == 0, onClick: (){
            controller.currentIndex.value = 0;
          }),
          itemHome('report_btn'.tr, Icon(Icons.report_rounded, size: 25, color: Colors.white,), Icon(Icons.report_outlined, size: 25, color: Colors.white,), controller.currentIndex.value == 1, onClick: (){
            controller.currentIndex.value = 1;
          }),
          itemHome("conf_btn".tr, Icon(Icons.settings_rounded, size: 25, color: Colors.white,), Icon(Icons.settings_outlined, size: 25, color: Colors.white,), controller.currentIndex.value == 2, onClick: (){
            controller.currentIndex.value = 2;
          }),
        ],
      ),
    );
  }

  itemHome(String title, Widget imgSelected, Widget imgUnselected, bool isSelected, {Function? onClick}){
    return Expanded(
      child: InkWell(
        child: Column(
          children: [
            isSelected ? imgSelected : imgUnselected,
            hSpace(3),
            Text(title, style: regularTextFont.copyWith(fontSize: fontSize(14), color: Colors.white),)
          ],
        ),
        onTap: (){
          onClick!();
        },
      ),
      flex: 1,
    );
  }
}
