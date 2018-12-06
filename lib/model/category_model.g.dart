// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) {
  return CategoryModel(
      json['courseId'] as int,
      json['id'] as int,
      json['order'] as int,
      json['name'] as String,
      json['parentChapterId'] as int,
      json['userControlSetTop'] as bool,
      json['visible'] as int,
      (json['children'] as List)
          .map((e) => e == null
              ? null
              : CategoryModel.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'courseId': instance.courseId,
      'id': instance.id,
      'order': instance.order,
      'name': instance.name,
      'parentChapterId': instance.parentChapterId,
      'userControlSetTop': instance.userControlSetTop,
      'visible': instance.visible,
      'children': instance.children
    };
