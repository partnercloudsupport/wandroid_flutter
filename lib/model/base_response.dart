import 'dart:convert' show json;

class BaseResponse<T> {
  int errorCode;
  T data;
  String errorMsg;

  factory BaseResponse(jsonStr, Function buildFun) => jsonStr is String
      ? BaseResponse.fromJson(json.decode(jsonStr), buildFun)
      : BaseResponse.fromJson(jsonStr, buildFun);

  BaseResponse.fromJson(jsonRes, Function buildFun) {
    errorCode = jsonRes['errorCode'];
    data = buildFun(jsonRes['data']);
    errorMsg = jsonRes['errorMsg'];
  }

  @override
  String toString() {
    return 'BaseResponse{errorCode: $errorCode, data: $data, errorMsg: $errorMsg}';
  }


}

class BaseResponseList<T> {
  int errorCode;
  String errorMsg;
  List<T> data;

  factory BaseResponseList(jsonStr, Function buildFun) => jsonStr is String
      ? BaseResponseList.fromJson(json.decode(jsonStr), buildFun)
      : BaseResponseList.fromJson(jsonStr, buildFun);

  BaseResponseList.fromJson(jsonRes, Function buildFun) {
    errorCode = jsonRes['errorCode'];
    errorMsg = jsonRes['errorMsg'];
    data = (jsonRes['data'] as List).map<T>((ele) => buildFun(ele)).toList();
  }

  @override
  String toString() {
    return 'BaseResponseList{errorCode: $errorCode, errorMsg: $errorMsg, data: $data}';
  }


}
