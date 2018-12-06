import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wandroid_flutter/model/article.dart';
import 'package:wandroid_flutter/model/banner.dart';
import 'package:wandroid_flutter/common/app_resource_config.dart';
import 'package:wandroid_flutter/api/api.dart';
import 'package:wandroid_flutter/api/api_service.dart';
import 'package:wandroid_flutter/model/base_list_model.dart';
import 'package:wandroid_flutter/model/base_response.dart';
import 'package:wandroid_flutter/model/banner_resp.dart';
import 'article_detail.dart';
import 'package:wandroid_flutter/widget/article_item.dart';


class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _defaultBannerImg =
      'http://www.wanandroid.com/blogimgs/50c115c2-cf6c-4802-aa7b-a4334de444cd.png';

  // 轮播图数据
  var _slideData = List<BannerModel>();

  // 文章列表数据
  var _articleData = List<ArticleModel>();
  double _screenWidth;

  final _scrollController = ScrollController();
  var _curPage = 1;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        debugPrint('滑动到了最底部');
        _onLoadMore();
      }
    });
    _getSlideList();
    _getArticleList(false);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        itemBuilder: (context, index) => _buildListView(context, index),
        itemCount: _articleData.length + 1,
        controller: _scrollController,
      ),
    );
  }

  /// buildListView
  Widget _buildListView(BuildContext context, int index) {
    // index == 0 时 展示轮播图
    if (index == 0) {
      bool _flag = _slideData == null || _slideData.length == 0;
      return Container(
        width: _screenWidth,
        height: 180.0,
        child: Swiper(
          itemBuilder: (context, i) => Image.network(
                _flag ? _defaultBannerImg : _slideData[i].imagePath,
                fit: BoxFit.fill,
              ),
          itemCount: _flag ? 1 : _slideData.length,
          pagination: SwiperPagination(),
          autoplay: true,
//          control: SwiperControl(),
          onTap: (i) {
            debugPrint('click banner $i');
          },
        ),
      );
    }

    // 展示 文章列表
    index -= 1;
    if (_articleData != null && _articleData.length > 0) {
      var _articleItem = _articleData[index];
      return ArticleItemWidget(_articleItem, index);
//
    }
    return Container(
      child: Center(
        child: Text('no data'),
      ),
    );
  }

  /// 刷新数据
  Future<Null> _onRefresh() async {
    _curPage = 1;
    _getSlideList();
    _getArticleList(false);
    return null;
  }

  /// 加载更多数据
  Future<Null> _onLoadMore() {
    _curPage++;
    _getArticleList(true);
    return null;
  }

  /// 获取banner数据
  _getSlideList() {
    ApiService().getBanners((BaseResponseList<BannerModel> res) {
      if (res != null && res.data != null && res.data.length > 0) {
        setState(() {
          _slideData = res.data;
        });
      }
      debugPrint('res====111:' + res.data[1].imagePath);
    });
  }

  /// 加载文章列表数据
  _getArticleList(bool isLoadMore) {
    ApiService().getHomeArticle(Api.HOME_LIST + '$_curPage/json',
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
