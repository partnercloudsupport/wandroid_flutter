import 'dart:async';
import 'package:dio/dio.dart';
import 'package:wandroid_flutter/api/api.dart';
import 'package:flutter/material.dart';
import 'package:wandroid_flutter/model/base_response.dart';
import 'package:wandroid_flutter/model/banner.dart';
import 'package:wandroid_flutter/model/banner_resp.dart';
import 'package:wandroid_flutter/model/base_list_model.dart';
import 'package:wandroid_flutter/model/article.dart';
import 'package:wandroid_flutter/model/category_model.dart';
import 'package:wandroid_flutter/model/hot_key.dart';
import 'package:wandroid_flutter/model/hot_website.dart';

class ApiService {
  void getBanner(Function callback) async {
    Dio().get(Api.HOME_BANNER).then((res) {
      callback(BannerResp.fromJson(res.data));
    });
  }

  void getBanners(Function callback) {
    Dio().get(Api.HOME_BANNER).then((res) {
      callback(BaseResponseList<BannerModel>.fromJson(
          res.data, (r) => BannerModel.fromJson(r)));
    });
  }

  void getCollects(int page, Function callback) {
    String path = '${Api.COLLECTED_ARTICLE}page/json';
    Dio().get(path).then((result) {
      var data = BaseResponse<BaseListModel<ArticleModel>>.fromJson(
          result.data,
          (res) => BaseListModel<ArticleModel>.fromJson(
              res, (r) => ArticleModel.fromJson(r)));
//      var data = BaseResponseList<BaseListModel<ArticleModel>>(
//          result.data, (res) => BaseListModel<ArticleModel>.fromJson(res.datas,(subRes)=>ArticleModel.fromJson(subRes)));
      callback(data);
    });
  }

  void getHomeArticle(String url, Function callback) {
    Dio().get(url).then((result) {
      var data = BaseResponse<BaseListModel<ArticleModel>>.fromJson(
          result.data,
          (res) => BaseListModel<ArticleModel>.fromJson(
              res, (r) => ArticleModel.fromJson(r)));
//      var data = BaseResponseList<BaseListModel<ArticleModel>>(
//          result.data, (res) => BaseListModel<ArticleModel>.fromJson(res.datas,(subRes)=>ArticleModel.fromJson(subRes)));
      callback(data);
    });
  }

  void getHotKeys(Function callback) {
    Dio().get(Api.HOT_KEYS).then((result) {
      var data = BaseResponseList<HotKeyModel>.fromJson(
          result.data, (r) => HotKeyModel.fromJson(r));
      callback(data);
    });
  }

  void getHotWebsites(Function callback) {
    Dio().get(Api.HOT_WEBSITES).then((result) {
      var data = BaseResponseList<HotWebsiteModel>.fromJson(
          result.data, (r) => HotWebsiteModel.fromJson(r));
      callback(data);
    });
  }

  void getCategoryTree(Function callback) {
    Dio().get(Api.TREES_LIST).then((result) {
      debugPrint('res======1' + result.toString());
      var data = BaseResponseList<CategoryModel>.fromJson(
          result.data, (r) => CategoryModel.fromJson(r));
      callback(data);
    });
  }

  Future<Response> login(String username, String password) async {
    FormData formData = new FormData.from({
      "username": "$username",
      "password": "$password",
    });
    return await Dio().post(Api.LOGIN, data: formData);
  }

//  void getCategoryTreeArticleList(String url,Function callback){
//    Dio().get(url).then((result) {
//      var data = BaseResponse<BaseListModel<ArticleModel>>.fromJson(
//      result.data,
//      (res) => BaseListModel<ArticleModel>.fromJson(
//      res, (r) => ArticleModel.fromJson(r)));
////      var data = BaseResponseList<BaseListModel<ArticleModel>>(
////          result.data, (res) => BaseListModel<ArticleModel>.fromJson(res.datas,(subRes)=>ArticleModel.fromJson(subRes)));
//      callback(data);
//      });
//  }

  void get(String url, Function callback, {Map<String, String> map}) async {
    Dio().get(url).then((result) {
      debugPrint('service---res1---:$result');
      var data = BaseResponseList<BannerModel>(
          result.data, (res) => BannerModel.fromJson(res)).data;
      debugPrint('service---res2---:' + data[1].imagePath);
      callback(BaseResponseList<BannerModel>.fromJson(
          result.data, (r) => BannerModel.fromJson(r)));
    });
  }

  Future<Response> searchArticle(String key, int page) async {
    FormData formData = FormData.from({'k': key});
    return await Dio().post('${Api.SEARCH_LIST}$page/json', data: formData);
  }

  Future<Response> collect(int id) async {
    return await Dio().post('${Api.COLLECT_IN_ARTICLE}$id/json}');
  }
}
