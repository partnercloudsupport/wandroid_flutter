import 'package:json_annotation/json_annotation.dart';
import 'root_model.dart';
import 'banner.dart';

part 'banner_resp.g.dart';
@JsonSerializable()
class BannerResp extends RootModel<List<BannerModel>> {
  BannerResp(
      List<BannerModel> data, int errorCode, String errorMsg)
      : super(data, errorCode, errorMsg);

  factory BannerResp.fromJson(Map<String, dynamic> json) =>
      _$BannerRespFromJson(json);

  toJson() => _$BannerRespToJson(this);
}