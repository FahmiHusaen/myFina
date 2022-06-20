import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:my_fina/base/theme.dart';
import 'package:my_fina/helper/spacing.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_screen_scaling/screen_scale_properties.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:html/parser.dart' show parse;
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

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

printLog(String msg){
  if (kDebugMode) {
    print(msg);
  }
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

isEmpty(TextEditingController edittext){
  if(edittext.text.isNotEmpty){
    return false;
  }
  return true;
}

String convertImagetoBase64(File fileData) {
  List<int> imageBytes = fileData.readAsBytesSync();
  return base64Encode(imageBytes);
}

isEmailValid(String email){
  return EmailValidator.validate(email);
}

launchURL(String url, {Map<String, String>? headers, bool? enableJs, bool? forceWebview}) async {
  if (await canLaunch(url)) {
    await launch(url,
        enableJavaScript: (enableJs != null) ? enableJs : false,
        forceWebView: (forceWebview != null) ? forceWebview : false);
  } else {
    throw 'Could not launch $url';
  }
}

String formattingDate2(String oriDate, String output) {
  initializeDateFormatting();
  var dateFormat;
  if (Platform.localeName.contains("id"))
    dateFormat = new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'", 'id_ID');
  else
    dateFormat = new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'", 'id_ID');

  DateTime dateTime = dateFormat.parse(oriDate);
  String formattedDate = DateFormat(output, 'id_ID').format(dateTime);
  return formattedDate;
}

String formattingDate(String oriDate, String input, String output) {
  initializeDateFormatting();
  var dateFormat;
  dateFormat = new DateFormat("$input", 'id_ID');

  DateTime dateTime = dateFormat.parse(oriDate);
  String formattedDate = DateFormat(output, 'id_ID').format(dateTime);
  return formattedDate;
}

DateTime convertDateFormat(
    String inFormat, String outFormat, String inputDate) {
  DateFormat inputFormat = DateFormat(inFormat);
  DateTime dateTime = inputFormat.parse(inputDate);
  DateFormat outputFormat = DateFormat(outFormat);
  return outputFormat.parse(dateTime.toString());
}

int getCurrentTimestamp() {
  return new DateTime.now().millisecondsSinceEpoch;
}

String getCurrentDate({String? outputFormat}){
  initializeDateFormatting();
  final now = new DateTime.now();
  String formatter = DateFormat((outputFormat == null) ? 'dd MMMM yyyy' : outputFormat, 'id_ID').format(now);
  return formatter;
}

String formattingNumber(dynamic number) {
  return NumberFormat.currency(locale: "id", symbol: "Rp ").format(number);

  // return display(number);
}

String secureNumber(String number) {
  return number.replaceAll(RegExp(r'.(?=.{4})'), '*');
}


closeKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(new FocusNode());
}

makeLine() {
  return Divider(
    color: line,
    thickness: ScreenScale.convertHeight(10),
  );
}

makeLineHeight(double heigh) {
  return Divider(
    color: line,
    thickness: heigh,
  );
}

makePullViewIndicator() {
  return Center(
    child: SizedBox(
      width: ScreenScale.convertWidth(50),
      height: ScreenScale.convertHeight(10),
      child: const Card(
        color: Colors.grey,
      ),
    ),
  );
}

viewEmpty() {
  return Container(
    width: Get.width,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset("assets/img/img_login.svg"),
        hSpace(10),
        Text(
          "Tidak ada data",
          style: boldTextFont.copyWith(fontSize: fontSize(14), color: textColor()),
        )
      ],
    ),
  );
}


border(Color borderColor){
  return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(wValue(10))),
      borderSide: BorderSide(
        color: borderColor,
      ));
}

Color hexToColor(String code) {
  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

Future<File?> compressFile(File file, String targetPath, {int? quality}) async {
  var result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    targetPath,
    quality: (quality != null) ? quality : 70,
  );

  return result;
}

Future<File> cropImage({required String path}) async {
  File? croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      compressQuality: 50,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        // CropAspectRatioPreset.ratio3x2,
        // CropAspectRatioPreset.original,
        // CropAspectRatioPreset.ratio4x3,
        // CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Accessive',
          toolbarColor: colorPrimary,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true),
      iosUiSettings: const IOSUiSettings(
          minimumAspectRatio: 1.0,
          title: "Accessive"
      )
  );

  return croppedFile!;
}

Future<File> cropImageWithOption({required String path}) async {
  File? croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      compressQuality: 50,
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Accessive',
          toolbarColor: colorPrimary,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: true),
      iosUiSettings: const IOSUiSettings(
          minimumAspectRatio: 1.0,
          title: "Accessive"
      )
  );

  return croppedFile!;
}

imgBill(String url, double width, double height){
  return Container(
    width: width,
    height: height,
    child: url.contains("http")
        ? Image.network(
      url,
      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace){
        return Text("An error occurred loading " + url);
      },
    )
        : Image.file(
        File(url),
      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace){
        return Text("An error occurred loading image");
      },
    ),
  );
}

circleAvatar(String url, double width, double height, {double? radius}) {
  return url.contains("http")
      ? Container(
    child: CircleAvatar(
      radius: radius ?? wValue(50),
      backgroundImage: const AssetImage("assets/img/img_placeholder.png"),
      backgroundColor: Colors.transparent,
      foregroundImage: NetworkImage(url),
    ),
    width: width,
    height: height,
  )
      : Container(
    child: CircleAvatar(
      radius: radius ?? wValue(50),
      backgroundImage: FileImage(File(url)),
    ),
    width: width,
    height: height,
  );
}

unFocusTextField(BuildContext context) {
  FocusScope.of(context).unfocus();
  new TextEditingController().clear();

  // FocusScope.of(context).requestFocus(null);
}

vLine({double? value}){
  return Container(
    width: wValue(1),
    height: value ?? 15,
    color: Colors.white,
  );
}


String parseHtmlString(String htmlString) {
  final document = parse(htmlString);
  final String parsedString = parse(document.body!.text).documentElement!.text;

  return parsedString;
}


imageRadius(String url, double width, double height, double radius,
    {String? placeholder}) {
  return Container(
    width: width,
    height: height,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.network(
        '$url',
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, exception, stackTrace) {
          return Image.asset(
            placeholder ?? "assets/img/img_placeholder.png",
            fit: BoxFit.cover,
          );
        },
      ),
    ),
  );
}

imageRadiusLocal(
    String path,
    double width,
    double height,
    double radius, {
      String? placeholder,
      bool? isFile,
    }) {
  return Container(
    width: width,
    height: height,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: isFile != null && isFile
          ? Image.file(
        File('$path'),
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, exception, stackTrace) {
          return Image.asset(
            placeholder == null
                ? "assets/img/img_placeholder.png"
                : placeholder,
            fit: BoxFit.cover,
          );
        },
      )
          : Image.asset(
        '$path',
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, exception, stackTrace) {
          return Image.asset(
            placeholder == null
                ? "assets/img/img_placeholder.png"
                : placeholder,
            fit: BoxFit.cover,
          );
        },
      ),
    ),
  );
}


String getErrorMessage(resp){
  String combinedMessage = "";
  printLog("type => ${resp.runtimeType}");
  if(resp is String){
    printLog("errors is string");
    return resp;
  }else if(resp is List<dynamic>){
    printLog("errors is list string");
    return resp.first.toString();
  }

  printLog("errors is i dont know");
  resp.forEach((key, messages) {
    for (var message in messages) {
      combinedMessage = combinedMessage + "- $message\n";
    }
  });

  return combinedMessage;
}

String getMessage(var resp){
  if(resp.data["message"] != null){
    return resp.data["message"];
  }

  if(resp.data["messages"] != null){
    return resp.data["messages"];
  }

  return "";
}