// ignore: import_of_legacy_library_into_null_safe
import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  String? category_id;
  String? user_id;
  String? name;
  DateTime? timestamp;

  CategoryModel.def(String category_id, String user_id, String name){
    this.user_id = user_id;
    this.name = name;
    this.category_id = category_id;
    this.timestamp = DateTime.now();
  }

  CategoryModel();

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}