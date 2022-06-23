import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_fina/model/category_model.dart';
import 'package:my_fina/model/transaction_model.dart';

class ReportController extends GetxController {
  RxBool isLoading = false.obs;

  RxInt totalIncomes = 0.obs;
  RxInt totalExpenses = 0.obs;
  RxDouble ExPerInPercent = 0.0.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String userId = FirebaseAuth.instance.currentUser!.uid;

  CollectionReference categoryRef = FirebaseFirestore.instance.collection("category").withConverter<CategoryModel>(
    fromFirestore: (snapshot, _) => CategoryModel.fromJson(snapshot.data()!),
    toFirestore: (CategoryModel, _) => CategoryModel.toJson(),
  );

  CollectionReference transRef = FirebaseFirestore.instance.collection("transaction").withConverter<TransactionModel>(
    fromFirestore: (snapshot, _) => TransactionModel.fromJson(snapshot.data()!),
    toFirestore: (TransactionModel, _) => TransactionModel.toJson(),
  );

  RxList<CategoryModel> categoryList = <CategoryModel>[].obs;

  RxList<List<TransactionModel>> listOfCategoricalTransList = <List<TransactionModel>>[].obs;
  RxList<int> categoricalExpenses = <int>[].obs;

  initController() async {
    readCategory();
  }

  readCategory() async {
    categoryList.value = <CategoryModel>[];
    categoricalExpenses.value = <int>[];

    await categoryRef
        .orderBy('timestamp', descending: true)
        .where('user_id', isEqualTo: userId)
        .get()
        .then((snapshot) {
      var listAllDocs = snapshot.docs;
      for (var docs in listAllDocs){
        CategoryModel? categoryModel = docs.data() as CategoryModel?;
        readTransPerCategory(categoryModel!);
      }
      print("transactionModel length : " + categoryList.length.toString());
    });
  }

  readTransPerCategory(CategoryModel categoryModel) async {

    await transRef
        .orderBy('timestamp', descending: true)
        .where('user_id', isEqualTo: userId)
        .where("category_id", isEqualTo: categoryModel.category_id)
        .get()
        .then((snapshot) {
      var listAllDocs = snapshot.docs;
      List<TransactionModel> transactionModelList = <TransactionModel>[];
      int newExpenses = 0;
      print("transaction " + categoryModel.name! + " length : " + transactionModelList.length.toString());
      for (var docs in listAllDocs){
        //var dataa = docs.data() as Map<String, dynamic>;
        TransactionModel? transactionModel = docs.data() as TransactionModel?;
        if(transactionModel!.is_income!){
          totalIncomes+=transactionModel.amount!;
          ExPerInPercent.value = totalExpenses/totalIncomes.value*100;
        } else {
          totalExpenses+=transactionModel.amount!;
          newExpenses+=transactionModel.amount!;
          ExPerInPercent.value = totalExpenses/totalIncomes.value*100;
        }
        transactionModelList.add(transactionModel);
      }
      listOfCategoricalTransList.add(transactionModelList);
      categoryList.add(categoryModel);
      categoricalExpenses.add(newExpenses);
      print("transaction " + categoryModel.name! + " length : " + transactionModelList.length.toString());
    });
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
