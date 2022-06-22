
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_fina/helper/global_helper.dart';
import 'package:my_fina/model/category_model.dart';
import 'package:my_fina/model/transaction_model.dart';
import 'package:my_fina/screens/login/login_screen.dart';
import 'package:my_fina/widget/loading.dart';
import 'package:my_fina/widget/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart' as d;
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
//import 'package:firebase_storage/firebase_storage.dart';

class CreateCategoryController extends GetxController {
  // var emailTxtController = TextEditingController().obs;
  var uuid = Uuid();
  String userId = FirebaseAuth.instance.currentUser!.uid;
  CollectionReference categoryRef = FirebaseFirestore.instance.collection("category").withConverter<CategoryModel>(
    fromFirestore: (snapshot, _) => CategoryModel.fromJson(snapshot.data()!),
    toFirestore: (CategoryModel, _) => CategoryModel.toJson(),
  );

  var categoryTxtCtrl = TextEditingController().obs;

  RxBool isLoading = false.obs;
  RxBool isCategoryValid = false.obs;
  RxString errorCategory = "".obs;

  initController() async {
    //setCurrentData();
  }

  void sendNewData(){
    validatingCategory();
    if(isCategoryValid.value){
      addCategory(categoryTxtCtrl.value.text ,
          (){
            successToast(msg: "Berhasil ditambahkan");
          }
      );
    } else {
      errorToast(msg: "Data tidak valid");
    }
  }

  Future<void> addCategory(String newCategory, Function? finished){
    String newId = uuid.v4();
    CategoryModel categoryModel1 = new CategoryModel.def(newId, userId, newCategory);

    return categoryRef
        .doc(newId)
        .set(categoryModel1)
        .then((value) {
      if(finished != null){
        finished();
      }
    })
        .catchError((onError) => errorToast(msg: "Gagal ditambahkan : " + onError.toString()));
  }

  void validatingCategory() {
    isCategoryValid.value = false;
    if (categoryTxtCtrl.value.text.toString().isEmpty) {
      errorCategory.value = "Kategori tidak boleh kosong";
    } else {
      errorCategory.value = "";
      isCategoryValid.value = true;
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
