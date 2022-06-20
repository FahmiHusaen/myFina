// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) {
  return CategoryModel()
    ..category_id = json['category_id'] as String?
    ..user_id = json['user_id'] as String?
    ..name = json['name'] as String?
    ..timestamp = json['timestamp'] == null
        ? null
        : DateTime.parse(json['timestamp'] as String);
}

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'category_id': instance.category_id,
      'user_id': instance.user_id,
      'name': instance.name,
      'timestamp': instance.timestamp?.toIso8601String(),
    };
