
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
//import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
//import 'package:firebase_storage/firebase_storage.dart';

class CreateTransactionController extends GetxController {
  // var emailTxtController = TextEditingController().obs;
  var uuid = Uuid();

  RxInt step = 0.obs;

  String userId = FirebaseAuth.instance.currentUser!.uid;
  CollectionReference transc = FirebaseFirestore.instance.collection("transaction").withConverter<TransactionModel>(
    fromFirestore: (snapshot, _) => TransactionModel.fromJson(snapshot.data()!),
    toFirestore: (TransactionModel, _) => TransactionModel.toJson(),
  );
  CollectionReference categoryRef = FirebaseFirestore.instance.collection("category").withConverter<CategoryModel>(
    fromFirestore: (snapshot, _) => CategoryModel.fromJson(snapshot.data()!),
    toFirestore: (CategoryModel, _) => CategoryModel.toJson(),
  );
  RxList<CategoryModel> categoryList = <CategoryModel>[].obs;
  CategoryModel selectedCategory = new CategoryModel.def("blank", "xxxx", "Pilih Kategori");

  var nameTxtCtrl = TextEditingController().obs;
  var amountTxtCtrl = TextEditingController().obs;
  var descTxtCtrl = TextEditingController().obs;

  Rx<File> selectedPhoto = File("").obs;

  RxBool isLoading = false.obs;

  RxString errorName = "".obs;
  // RxString errorEmail = "".obs;
  RxString errorAmount = "".obs;
  RxString errorDesc = "".obs;

  RxBool isNameValid = false.obs;
  RxBool isAmountValid = false.obs;
  //RxBool isdescValid = false.obs;
  RxBool isCategoryValid = false.obs;

  RxBool isIncome = false.obs;

  initController() async {
    //setCurrentData();
  }

  initCategory() async {
    readCategory();
    selectedPhoto.value = File("");
  }

  readCategory() async {
    categoryList.value = <CategoryModel>[];
    selectedCategory = new CategoryModel.def("blank", "xxxx", "Pilih Kategori");
    categoryList.add(selectedCategory);

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
          selectedCategory = categoryList.value[0];
          print("transactionModel length : " + categoryList.length.toString());
    });
  }

  setCurrentData(){
    //emailTxtController.value.text = "";
    //nameTxtCtrl.value.text = user.value.full_name ?? "";
    //phoneTxtCtrl.value.text = user.value.phone ?? "";
    //usernameTxtCtrl.value.text = user.value.user_name!;
  }

  void sendNewData(){
    validatingName();
    validatingAmount();
    validatingCategory();
    if(isNameValid.value && isAmountValid.value && isCategoryValid.value){
      createData(
          (){
            successToast(msg: "Berhasil ditambahkan");
          }
      );
    } else {
      errorToast(msg: "Data tidak valid");
    }
  }

  Future createData(Function? finished){
    String newId = uuid.v4();
    TransactionModel transactionModelSample1 = new TransactionModel.def(newId, userId, nameTxtCtrl.value.text, selectedCategory.category_id!,
        descTxtCtrl.value.text, int.parse(amountTxtCtrl.value.text), isIncome.value, "");

    return transc
        .doc(newId)
        .set(transactionModelSample1)
        .then((value) {
          if(finished != null){
            finished();
          }
        })
        .catchError((onError) {
          errorToast(msg: "Data gagal ditambahkan : " + onError.toString());
        });
  }

  void validatingName() {
    isNameValid.value = false;
    if (nameTxtCtrl.value.text.toString().isEmpty) {
      errorName.value = "Nama tidak boleh kosong";
    } else {
      errorName.value = "";
      isNameValid.value = true;
    }
  }

  void validatingAmount(){
    isAmountValid.value = false;
    if(amountTxtCtrl.value.text.toString().isNotEmpty){
      if( amountTxtCtrl.value.text.isNotEmpty && amountTxtCtrl.value.text.length > 9){
        errorAmount.value = "Harus kurang dari 1 milyar";
      }else{
        errorAmount.value = "";
      isAmountValid.value = true;
    }
  }else{
  errorAmount.value = "Nominal tidak boleh kosong";
    }
  }

  void validatingCategory(){
    isCategoryValid.value = false;
    if(selectedCategory.category_id != "blank") {
      isCategoryValid.value = true;
    } else {
      isCategoryValid.value = false;
      errorToast(msg: "Kategori belum dipilih");
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
