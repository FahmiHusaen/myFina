import 'package:my_fina/base/theme.dart';
import 'package:my_fina/helper/global_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_fina/helper/spacing.dart';
import 'package:my_fina/screens/create_transaction/create_transaction_screen.dart';
import 'package:my_fina/screens/main/history/history_controller.dart';
import 'package:my_fina/widget/shimmer.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  var controller = HistoryController();

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
                  child: Text('history_title'.tr, style: boldTextFont.copyWith(fontSize: fontSize(27),
                      color:  Get.isPlatformDarkMode ? Colors.white : black1),),
                ), flex: 1,),
                Container(
                  child: InkWell(
                      child: Icon(Icons.add_circle_outline),
                    onTap: (){
                      //controller.sendSample();
                      goToPage(CreateTransactionScreen(), context: context);
                    },
                  ),
                )
              ],
            ),
            hSpace(15),
            Expanded(child: controller.isLoading.value ? showShimmerList() : RefreshIndicator(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  child: Column(
                    children: [
                      for (var item in controller.transList)
                        Container(
                          width: Get.width,
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              //color: Colors.black,
                              padding: EdgeInsets.all(wValue(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    //mainAxisAlignment: MainAxisAlignment.start,
                                    //crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(item.timestamp.toString().substring(0,10), style: boldTextFont.copyWith(fontSize: fontSize(14)),),
                                      Spacer(flex: 1,),
                                      Text(item.is_income! ? "+ " + item.amount.toString() : "- " + item.amount.toString(),
                                        style: boldTextFont.copyWith(fontSize: fontSize(18), color: item.is_income! ? Colors.green : Colors.red),)
                                    ],
                                  ),
                                  Text(item.name.toString(), style: boldTextFont.copyWith(fontSize: fontSize(16)),),
                                  Text(item.category_name.toString(), style: boldTextFont.copyWith(fontSize: fontSize(14)),),
                                  Visibility(visible: (item.desc.toString()!=""), child: Text(item.desc.toString(), style: boldTextFont.copyWith(fontSize: fontSize(14)),)),
                                ],
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
            onRefresh: onRefresh,)
            )
            ],
        ),
        padding: EdgeInsets.only(bottom: hValue(85), left: wValue(25), right: wValue(25)),
     )
      ),
    );
  }

  Future onRefresh() async{
    controller.refreshController();
  }
}

