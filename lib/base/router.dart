import 'package:my_fina/screens/splash/splash_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class Router {
  static final route = [
    GetPage(
      name: '/splashScreen',
      page: () => SplashScreen(),
    ),
  ];
}