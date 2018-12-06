import 'dart:convert' show json;

class BaseListModel<T> {
  List<T> datas;
  int curPage;
  int offset;
  int pageCount;
  int total;

  factory BaseListModel(jsonStr, Function buildFun) => jsonStr is String
      ? BaseListModel.fromJson(json.decode(jsonStr), buildFun)
      : BaseListModel.fromJson(jsonStr, buildFun);

  BaseListModel.fromJson(jsonRes, Function buildFun) {
    datas = (jsonRes['datas'] as List).map<T>((ele) => buildFun(ele)).toList();
    curPage = jsonRes['curPage'];
    offset = jsonRes['offset'];
    pageCount = jsonRes['pageCount'];
    total = jsonRes['total'];
  }

  @override
  String toString() {
    return 'BaseListModel{datas: $datas, curPage: $curPage, offset: $offset, pageCount: $pageCount, total: $total}';
  }


}

