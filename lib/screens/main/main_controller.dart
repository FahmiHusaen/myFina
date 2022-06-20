import 'dart:async';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_fina/screens/main/configuration/configuration_controller.dart';
import 'package:my_fina/screens/main/configuration/configuration_screen.dart';
import 'package:my_fina/screens/main/history/history_screen.dart';
import 'package:my_fina/screens/main/report/report_screen.dart';

class MainController extends GetxController {
  var box = GetStorage();
  RxInt currentIndex = 0.obs;

  initController() async {

  }

  void setCurrentIndex(int index) async {
    currentIndex.value = index;
  }

  setCurrentPage({required int index}) {
    if (index == 0) {
      return const HistoryScreen();
    } else if (index == 1) {
      return const ReportScreen();
    } else if (index == 2) {
      return const ConfigurationScreen();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
