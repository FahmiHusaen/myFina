// ignore: import_of_legacy_library_into_null_safe
import 'package:json_annotation/json_annotation.dart';

part 'transaction_model.g.dart';

@JsonSerializable()
class TransactionModel {
  String? transaction_id;
  String? user_id;
  String? name;
  String? category_id;
  String? category_name;
  String? desc;
  int? amount;
  bool? is_income;
  String? invoice_photo_url;
  DateTime? timestamp;

  TransactionModel.def(String transaction_id, String user_id, String name, String category_id, String desc, int amount, bool is_income, String invoice_photo_url){
    this.transaction_id = transaction_id;
    this.user_id = user_id;
    this.name = name;
    this.category_id = category_id;
    this.desc = desc;
    this.amount = amount;
    this.is_income = is_income;
    this.invoice_photo_url = invoice_photo_url;
    this.timestamp = DateTime.now();
    this.category_name = "";
  }

  TransactionModel();

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);
}