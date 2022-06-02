import 'package:get/get.dart';

class Translator extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'id_ID': {
      'app_name': 'Guru Inovatif',
      'failed_get_data' : 'Gagal mengambil data',
    },
    'en_US': {
      'app_name': 'Guru Inovatif',
      'failed_get_data' : 'Failed get data',
    }
  };
}