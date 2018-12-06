import 'package:json_annotation/json_annotation.dart';

part 'hot_website.g.dart';

@JsonSerializable()
class HotWebsiteModel {
  int id;
  String link;
  String name;
  int order;
  int visible;
  String icon;

  HotWebsiteModel(
      this.id, this.link, this.name, this.order, this.visible, this.icon);


  factory HotWebsiteModel.fromJson(Map<String, dynamic> json) =>
      _$HotWebsiteModelFromJson(json);

  Map<String, dynamic> toJson() => _$HotWebsiteModelToJson(this);
}
