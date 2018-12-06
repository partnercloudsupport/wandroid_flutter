import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  int courseId;
  int id;
  int order;
  String name;
  int parentChapterId;
  bool userControlSetTop;
  int visible;
  List<CategoryModel> children;

  CategoryModel(this.courseId, this.id, this.order, this.name,this.parentChapterId,
      this.userControlSetTop, this.visible, this.children);

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  @override
  String toString() {
    return 'CategoryModel{courseId: $courseId, id: $id, order: $order, name: $name, parentChapterId: $parentChapterId, userControlSetTop: $userControlSetTop, visible: $visible, children: $children}';
  }


}
