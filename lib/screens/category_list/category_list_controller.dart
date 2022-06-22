import 'dart:convert';
//import 'dart:ffi';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_fina/model/category_model.dart';
import 'package:my_fina/model/transaction_model.dart';
import 'package:my_fina/widget/toast.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';


class CategoryListController extends GetxController {
  RxBool isLoading = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String userId = FirebaseAuth.instance.currentUser!.uid;

  CollectionReference categoryRef = FirebaseFirestore.instance.collection("category").withConverter<CategoryModel>(
    fromFirestore: (snapshot, _) => CategoryModel.fromJson(snapshot.data()!),
    toFirestore: (CategoryModel, _) => CategoryModel.toJson(),
  );

  RxList<CategoryModel> categoryList = <CategoryModel>[].obs;

  initController() async {
    readCategory();
  }

  refreshController() async {
    readCategory();
  }

  readCategory() async {
    categoryList.value = <CategoryModel>[];

    await categoryRef
        .orderBy('timestamp', descending: true)
        .where('user_id', isEqualTo: userId)
        .get()
        .then((snapshot) {
      var listAllDocs = snapshot.docs;
      for (var docs in listAllDocs){
        CategoryModel? transactionModel = docs.data() as CategoryModel?;
        categoryList.add(transactionModel!);
      }

      print("transactionModel length : " + categoryList.length.toString());
    });
  }

  Future<void> removeCategory(CategoryModel categoryModel){
    return categoryRef
        .doc(categoryModel.category_id)
        .delete()
        .then((value) {
      successToast(msg: "Kategori " + categoryModel.name! + " Terhapus");
      refreshController();
    })
        .catchError((error) => errorToast(msg: "Kategori " + categoryModel.name! + " Gagal Terhapus"));
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
