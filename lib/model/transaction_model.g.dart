// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) {
  return TransactionModel()
    ..transaction_id = json['transaction_id'] as String?
    ..user_id = json['user_id'] as String?
    ..name = json['name'] as String?
    ..category_id = json['category_id'] as String?
    ..desc = json['desc'] as String?
    ..amount = json['amount'] as int?
    ..is_income = json['is_income'] as bool?
    ..invoice_photo_url = json['invoice_photo_url'] as String?
    ..timestamp = json['timestamp'] == null
        ? null
        : DateTime.parse(json['timestamp'] as String);
}

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'transaction_id': instance.transaction_id,
      'user_id': instance.user_id,
      'name': instance.name,
      'category_id': instance.category_id,
      'desc': instance.desc,
      'amount': instance.amount,
      'is_income': instance.is_income,
      'invoice_photo_url': instance.invoice_photo_url,
      'timestamp': instance.timestamp?.toIso8601String(),
    };
