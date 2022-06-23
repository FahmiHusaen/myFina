import 'package:my_fina/base/theme.dart';
import 'package:my_fina/helper/global_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_fina/helper/spacing.dart';
import 'package:my_fina/screens/main/history/history_controller.dart';
import 'package:my_fina/screens/main/report/report_controller.dart';
import 'package:simple_shadow/simple_shadow.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {

  var controller = ReportController();

  @override
  void initState() {
    controller.initController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      color: bgPage(),
      child:
      Obx(()=>
          Container(
        child: RefreshIndicator(
          onRefresh: onRefresh,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
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
                      child: Text('report_title'.tr, style: boldTextFont.copyWith(fontSize: fontSize(27),
                          color:  Get.isPlatformDarkMode ? Colors.white : black1),),
                    ), flex: 1,),
                  ],
                ),
                Text('month'.tr + " " + getMonth(DateTime.now().month), style: regularTextFont.copyWith(fontSize: fontSize(16), color: textColor()),),
                hSpace(15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('used'.tr, style: regularTextFont.copyWith(fontSize: fontSize(16), color: textColor()),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(controller.ExPerInPercent.value.toString() + "%", style: boldTextFont.copyWith(fontSize: fontSize(100),
                        color:  colorPrimary),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Rp " + controller.totalExpenses.value.toString() ,style: regularTextFont.copyWith(fontSize: fontSize(20), color: colorPrimary),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(' ' + 'from'.tr + ' ' ,style: regularTextFont.copyWith(fontSize: fontSize(16), color: textColor()),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Rp " + controller.totalIncomes.value.toString() ,style: regularTextFont.copyWith(fontSize: fontSize(20), color: colorPrimary),),
                  ],
                ),
                hSpace(15),
                Text('outcome_list'.tr, style: regularTextFont.copyWith(fontSize: fontSize(16), color: textColor()),),
                hSpace(15),
                for(int i=0; i < controller.categoryList.length; i++)
                  itemExpensesCategory(controller.categoryList.value[i].name!, controller.categoricalExpenses.value[i].toString())
                ],
            ),
          ),
        ),
        padding: EdgeInsets.only(bottom: hValue(85), left: wValue(25), right: wValue(25)),
    )
    ),
    );
  }

  Future onRefresh() async {
    controller.initController();
  }

  itemExpensesCategory(String title, String expenses, {Function? action}){
    return  SimpleShadow(
      child: Container(
        decoration: BoxDecoration(
          color: Get.isPlatformDarkMode ? darkBright : Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: EdgeInsets.only(bottom: hValue(10)),
        padding: EdgeInsets.all(wValue(10)),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Text(title, style: boldTextFont.copyWith(fontSize: fontSize(17), color: textColor()),), flex: 1,),
                wSpace(10),
                //Icon(Icons.navigate_next, size: wValue(17), color: black1),
              ],
            ),
            Row(
              children: [
                Text(expenses, style: regularTextFont.copyWith(fontSize: fontSize(17), color: textColor()),),
              ],
            ),
          ],
        ),
      ),
      opacity: 0.3,
      color: Colors.black.withAlpha(80),
      offset: const Offset(-2, 3),
      sigma: 5,
    );
  }
}

