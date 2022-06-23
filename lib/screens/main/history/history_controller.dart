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


class HistoryController extends GetxController {
  RxBool isLoading = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String userId = FirebaseAuth.instance.currentUser!.uid;

  CollectionReference transc = FirebaseFirestore.instance.collection("transaction").withConverter<TransactionModel>(
    fromFirestore: (snapshot, _) => TransactionModel.fromJson(snapshot.data()!),
    toFirestore: (TransactionModel, _) => TransactionModel.toJson(),
  );

  CollectionReference categoryRef = FirebaseFirestore.instance.collection("category").withConverter<CategoryModel>(
    fromFirestore: (snapshot, _) => CategoryModel.fromJson(snapshot.data()!),
    toFirestore: (CategoryModel, _) => CategoryModel.toJson(),
  );

  RxList<TransactionModel> transList = <TransactionModel>[].obs;

  var uuid = Uuid();

  initController() async {
    readSample();
    //addSampleCategory("Obat obatan");
    //addSampleCategory("Anak anak");
    //addSampleCategory("Rekreasi");
  }

  refreshController() async {
    readSample();
  }

  Future<void> sendSample(){
    int randomAmount = Random().nextInt(100) * 10000;
    bool randomIncome = Random().nextBool();
    String newId = uuid.v4();
    TransactionModel transactionModelSample1 = new TransactionModel.def(newId, userId, "Susu Appeton", "krn",
        "Loreup Ipsum Dolor sir amet", randomAmount, randomIncome, "xxx.com");

    return transc
        .doc(newId)
        .set(transactionModelSample1)
        .then((value) => successToast(msg: "Berhasil ditambahkan"))
        .catchError((onError) => errorToast(msg: "Gagal ditambahkan : " + onError.toString()));
  }

  readSample() async {
    transList.value = <TransactionModel>[];

    await transc
        .orderBy('timestamp', descending: true)
        .where('user_id', isEqualTo: userId)
        .get()
        .then((snapshot) {
          var listAllDocs = snapshot.docs;
          for (var docs in listAllDocs){
            //var dataa = docs.data() as Map<String, dynamic>;
            TransactionModel? transactionModel = docs.data() as TransactionModel?;
            addToModel(transactionModel!);
          }
          print("transactionModel length : " + transList.length.toString());
     });
  }

  addToModel(TransactionModel transactionModel) async {
    await categoryRef
        .doc(transactionModel.category_id)
        .get()
        .then((value){
          String newName = value.get("name");
          transactionModel.category_name = newName;
          transList.add(transactionModel);
    })
        .catchError((error) => errorToast(msg: "Error add to model transcation : " + error.toString()));
  }

  Future<void> addSampleCategory(String newCategory){
    String newId = uuid.v4();
    CategoryModel categoryModel1 = new CategoryModel.def(newId, userId, newCategory);

    return categoryRef
        .doc(newId)
        .set(categoryModel1)
        .then((value) => successToast(msg: "Kategori " + newCategory + "Berhasil ditambahkan"))
        .catchError((onError) => errorToast(msg: "Gagal ditambahkan : " + onError.toString()));
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
