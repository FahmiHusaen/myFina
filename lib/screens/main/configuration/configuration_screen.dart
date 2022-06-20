import 'package:my_fina/base/theme.dart';
import 'package:my_fina/helper/global_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_fina/helper/spacing.dart';
import 'package:my_fina/screens/main/history/history_controller.dart';

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
      child: Obx(()=> Container(
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
                  child: Text("Konfigurasi.", style: boldTextFont.copyWith(fontSize: fontSize(27),
                      color:  Get.isPlatformDarkMode ? Colors.white : black1),),
                ), flex: 1,),
              ],
            ),
            ],
        ),
        padding: EdgeInsets.only(bottom: hValue(85), left: wValue(25), right: wValue(25)),
      )),
    );
  }
}

