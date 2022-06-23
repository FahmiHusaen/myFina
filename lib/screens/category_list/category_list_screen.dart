import 'package:my_fina/base/theme.dart';
import 'package:my_fina/helper/global_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_fina/helper/spacing.dart';
import 'package:my_fina/model/category_model.dart';
import 'package:my_fina/screens/category_list/category_list_controller.dart';
import 'package:my_fina/screens/create_category/create_category_screen.dart';
import 'package:my_fina/screens/create_transaction/create_transaction_screen.dart';
import 'package:my_fina/screens/main/history/history_controller.dart';
import 'package:my_fina/widget/button.dart';
import 'package:my_fina/widget/shimmer.dart';
import 'package:simple_shadow/simple_shadow.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({Key? key}) : super(key: key);

  @override
  _CategoryListScreenState createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {

  var controller = CategoryListController();

  @override
  void initState() {
    controller.initController();
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
                        child: Text('set_category_title'.tr, style: boldTextFont.copyWith(fontSize: fontSize(27),
                            color:  Get.isPlatformDarkMode ? Colors.white : black1),),
                      ), flex: 1,),
                      Container(
                        child: InkWell(
                          child: Icon(Icons.add_circle_outline),
                          onTap: (){
                            //controller.sendSample();
                            goToPage(CreateCategoryScreen(), context: context);
                          },
                        ),
                      )
                    ],
                  ),
                  hSpace(29),
                  Expanded(child: controller.isLoading.value ? showShimmerList() :
                  RefreshIndicator(child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    child: Column(
                      children: [
                        for(var item in controller.categoryList) itemCategory(item)
                      ],
                    ),
                  ), onRefresh: onRefresh)),
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

  itemCategory(CategoryModel categoryModel){
    return SimpleShadow(
        child: Container(
        decoration: BoxDecoration(
          color: Get.isPlatformDarkMode ? darkBright : Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: EdgeInsets.only(bottom: hValue(10)),
        padding: EdgeInsets.all(wValue(10)),
        child: Row(
          children: [
            Expanded(child: Text(categoryModel.name!, style: boldTextFont.copyWith(fontSize: fontSize(17), color: textColor()),), flex: 1,),
            wSpace(10),
            InkWell(
              child: Icon(Icons.delete, size: wValue(17), color: black1),
              onTap: (){
                controller.removeCategory(categoryModel);
              },
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


  Future onRefresh() async{
    controller.refreshController();
  }
}

