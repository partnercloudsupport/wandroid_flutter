import 'package:flutter/material.dart';
import 'package:wandroid_flutter/model/article.dart';
import 'package:wandroid_flutter/widget/article_item.dart';
import 'package:wandroid_flutter/api/api_service.dart';
import 'package:wandroid_flutter/model/base_response.dart';
import 'package:wandroid_flutter/model/base_list_model.dart';

class CollectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CollectPage();
}

class _CollectPage extends State<CollectPage> {
  final _articleData = List<ArticleModel>();

  /// 列表用的滑动监听控制器。这里可以点进去看看它里面有哪些参数和方法。
  ScrollController _scrollController = ScrollController();
  var _curPage = 0;

  @override
  void initState() {
    _scrollController
      ..addListener(() {
        if (_scrollController.position.maxScrollExtent ==
            _scrollController.position.pixels) {
          _onLoadMore();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            '我的收藏',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: RefreshIndicator(
            child: _articleData.length == 0
                ? Container(
                    child: Center(
                      child: Text('no data'),
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: _articleData.length,
                    itemBuilder: (context, index) =>
                        _buildListView(context, index),
                  ),
            onRefresh: _onRefresh));
  }

  Future<Null> _onRefresh() {
    _curPage = 0;
    _getArticles(false);
    return null;
  }

  Future<Null> _onLoadMore() {
    _curPage++;
    _getArticles(true);
    return null;
  }

  _getArticles(bool isLoadMore) {
    ApiService().getCollects(_curPage,
        (BaseResponse<BaseListModel<ArticleModel>> res) {
      if (res != null && res.data != null && res.data.datas != null) {
        setState(() {
          if (!isLoadMore) {
            _articleData.clear();
          }
          _articleData.addAll(res.data.datas);
        });
      }
    });
  }

  /// _buildListView
  Widget _buildListView(BuildContext context, int index) {
    var _articleItem = _articleData[index];
    return ArticleItemWidget(_articleItem, index);
  }
}
