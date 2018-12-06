import 'package:json_annotation/json_annotation.dart';

part 'banner.g.dart';

/// 轮播图 banner
@JsonSerializable()
class BannerModel {
  String image;
  String desc;
  int id;
  String imagePath;
  int isVisible;
  int order;
  String title;
  int type;
  String url;

  BannerModel(this.image, this.desc, this.id, this.imagePath, this.isVisible,
      this.order, this.title, this.type, this.url);

  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);

  Map<String, dynamic> toJson() => _$BannerModelToJson(this);

  @override
  String toString() {
    return 'BannerModel{image: $image, desc: $desc, id: $id, imagePath: $imagePath, isVisible: $isVisible, order: $order, title: $title, type: $type, url: $url}';
  }


}
