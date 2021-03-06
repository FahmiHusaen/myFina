import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'base/router.dart' as rt;
//import 'data/MyHttpOverrides.dart';
import 'helper/translator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  //HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp();
  runApp(MyApp());
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? locale;
  var box = GetStorage();

  getCurrentLocale(){
    if(box.read("KEY_LANG") != null && box.read("KEY_COUN") != null){
      try {
        //locale = box.read("KEY_LOCALE");
        locale = Locale(box.read("KEY_LANG").toString(), box.read("KEY_COUN").toString());
      } catch (_) {
        locale = Locale('en', 'US');
      }
    } else {
      locale = Locale('en', 'US');
      box.write("KEY_LANG", 'en');
      box.write("KEY_COUN", 'US');
    }
  }

  @override
  void initState(){
    super.initState();
    //var locale = const Locale('en', 'US');
    getCurrentLocale();
    Get.updateLocale(locale!);
    Firebase.initializeApp();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Accesive',
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fadeIn,
      translations: Translator(),
      locale: locale,
      getPages: rt.Router.route,
      initialRoute: '/splashScreen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            }
        ),
      ),
    );
  }
}
