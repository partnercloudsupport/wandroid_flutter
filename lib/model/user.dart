import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel{
  int id;
  String username;
  String password;
  String email;
  String icon;
  int type;
  List<int> collectIds;
  String token;

  UserModel(this.id, this.username, this.password, this.email, this.icon,
      this.type, this.collectIds, this.token);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

}