// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hot_website.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotWebsiteModel _$HotWebsiteModelFromJson(Map<String, dynamic> json) {
  return HotWebsiteModel(
      json['id'] as int,
      json['link'] as String,
      json['name'] as String,
      json['order'] as int,
      json['visible'] as int,
      json['icon'] as String);
}

Map<String, dynamic> _$HotWebsiteModelToJson(HotWebsiteModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'link': instance.link,
      'name': instance.name,
      'order': instance.order,
      'visible': instance.visible,
      'icon': instance.icon
    };
