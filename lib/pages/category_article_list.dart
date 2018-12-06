import 'package:flutter/material.dart';
import 'package:wandroid_flutter/api/api_service.dart';
import 'package:wandroid_flutter/api/api.dart';
import 'package:wandroid_flutter/model/base_response.dart';
import 'package:wandroid_flutter/model/article.dart';
import 'package:wandroid_flutter/widget/article_item.dart';
import 'package:wandroid_flutter/model/base_list_model.dart';

class CategoryArticleListPage extends StatefulWidget {
  final _categoryId;

  CategoryArticleListPage(this._categoryId);

  @override
  State<StatefulWidget> createState() =>
      _CategoryArticleListPageState(_categoryId);
}

class _CategoryArticleListPageState extends State<CategoryArticleListPage> {
  final _categoryId;
  var _curPage = 0;

  _CategoryArticleListPageState(this._categoryId);

  final _articleData = List<ArticleModel>();
  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        debugPrint('滑动到了最底部');
        _onLoadMore();
      }
    });
    _onRefresh();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        itemCount: _articleData.length,
        controller: _scrollController,
        itemBuilder: (context, index) {
          if (_articleData != null && _articleData.length > 0) {
            var _articleItem = _articleData[index];
            return ArticleItemWidget(_articleItem, index);
          }
          return Container(
            child: Center(
              child: Text('no data'),
            ),
          );
        },
      ),
    );
  }

  Future<Null> _onRefresh() {
    _curPage = 0;
    _getArticleList(false);
    return null;
  }

  Future<Null> _onLoadMore() {
    _curPage++;
    _getArticleList(true);
    return null;
  }

  /// 获取文章列表数据
  _getArticleList(bool isLoadMore) {
    String url = '${Api.TREES_DETAIL_LIST}$_curPage/json?cid=$_categoryId';
    ApiService().getHomeArticle(url,
        (BaseResponse<BaseListModel<ArticleModel>> res) {
      if (res != null && res.data != null && res.data.datas != null) {
        setState(() {
          if (!isLoadMore) {
            _articleData.clear();
          }
          _articleData.addAll(res.data.datas);
//          SnackBar(content: Text("新增了${res.data.datas.length}条数据"));
        });
      }
    });
  }
}
