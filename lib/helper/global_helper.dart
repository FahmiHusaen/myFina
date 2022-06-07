import 'package:flutter/cupertino.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';

goToPage(Widget page, {bool? dismissPage, bool? dismissAllPage, required BuildContext context}){
  if(dismissPage != null){
    Navigator.of(context).pushReplacement(createRoute(page));
    return;
  }

  if(dismissAllPage !=null){
    if(dismissAllPage){
      Get.offAll(page);
      return;
    }
  }
  Navigator.of(context).push(createRoute(page));
}

Route createRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

isEmailValid(String email){
  return EmailValidator.validate(email);
}