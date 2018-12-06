// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
      json['id'] as int,
      json['username'] as String,
      json['password'] as String,
      json['email'] as String,
      json['icon'] as String,
      json['type'] as int,
      (json['collectIds'] as List)?.map((e) => e as int)?.toList(),
      json['token'] as String);
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'password': instance.password,
      'email': instance.email,
      'icon': instance.icon,
      'type': instance.type,
      'collectIds': instance.collectIds,
      'token': instance.token
    };
