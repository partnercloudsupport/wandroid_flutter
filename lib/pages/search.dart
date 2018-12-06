import 'package:flutter/material.dart';
import 'package:wandroid_flutter/model/article.dart';
import 'package:wandroid_flutter/widget/article_item.dart';
import 'package:wandroid_flutter/api/api_service.dart';
import 'package:wandroid_flutter/model/base_response.dart';
import 'package:wandroid_flutter/model/base_list_model.dart';

class SearchPage extends StatefulWidget {
  final _searchStr;

  SearchPage(this._searchStr);

  @override
  State<StatefulWidget> createState() => _SearchPageState(_searchStr);
}

class _SearchPageState extends State<SearchPage> {
  /// 用来搜索的关键字
  var _searchStr = '';

  _SearchPageState(this._searchStr);

  /// 用来控制清除输入icon的显不显示
  var _showClear = false;

  /// 输入框架controller
  var _textFieldController;

  /// 列表用的滑动监听控制器。这里可以点进去看看它里面有哪些参数和方法。
  ScrollController _scrollController = ScrollController();

  final _articleData = List<ArticleModel>();

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
    //如果这个时候传入了搜索词就出发搜索
    if (_searchStr == null || _searchStr.isEmpty) {
      _textFieldController = TextEditingController();
    } else {
      _textFieldController = TextEditingController(text: _searchStr);
      _showClear = true;
      _searchArticle(false);
    }
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _textFieldController,
          textInputAction: TextInputAction.search,
          onSubmitted: (content) {
            _searchStr = content;
            _searchArticle(false);
          },
          onChanged: (content) {
            setState(() {
              _showClear = content != null && content.isNotEmpty;
            });
          },
          decoration: InputDecoration(
            hintText: '请输入搜索内容',
            hintStyle: TextStyle(color: Colors.white),
          ),
          maxLines: 1,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          _showClear
              ? IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _textFieldController.clear();
                  },
                )
              : Container(),
        ],
        // icon的主题设置
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: RefreshIndicator(
        child: ListView.builder(
          itemBuilder: (context, index) => _buildListView(context, index),
          itemCount: _articleData.length,
          controller: _scrollController,
        ),
        onRefresh: _onRefresh,
      ),
    );
  }

  /// _buildListView
  Widget _buildListView(BuildContext context, int index) {
    var _articleItem = _articleData[index];
    return ArticleItemWidget(_articleItem, index);
  }

  Future<Null> _onRefresh() async {
    _curPage = 0;
    _searchArticle(false);
    return null;
  }

  Future<Null> _onLoadMore() {
    _curPage++;
    _searchArticle(true);
    return null;
  }

  /// _searchArticle
  _searchArticle(bool isLoadMore) {
    ApiService().searchArticle(_searchStr, _curPage).then((result) {
      BaseResponse<BaseListModel<ArticleModel>> data =
          BaseResponse<BaseListModel<ArticleModel>>.fromJson(
              result.data,
              (res) => BaseListModel<ArticleModel>.fromJson(
                  res, (r) => ArticleModel.fromJson(r)));
      if (data != null) {
        setState(() {
          if (!isLoadMore) {
            _articleData.clear();
          }
          _articleData.addAll(data.data.datas);
        });
      }
    });
  }
}
