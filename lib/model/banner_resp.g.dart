// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerResp _$BannerRespFromJson(Map<String, dynamic> json) {
  return BannerResp(
      (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : BannerModel.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['errorCode'] as int,
      json['errorMsg'] as String);
}

Map<String, dynamic> _$BannerRespToJson(BannerResp instance) =>
    <String, dynamic>{
      'errorCode': instance.errorCode,
      'data': instance.data,
      'errorMsg': instance.errorMsg
    };
