import 'package:flutter/material.dart';
import 'package:wandroid_flutter/model/article.dart';
import 'package:wandroid_flutter/pages/article_detail.dart';
import 'package:wandroid_flutter/common/app_resource_config.dart';
import 'package:wandroid_flutter/api/api_service.dart';
import 'package:wandroid_flutter/model/base_response.dart';
import 'package:wandroid_flutter/model/base_list_model.dart';

class ArticleItemWidget extends StatelessWidget {
  final ArticleModel _articleItem;
  final _index;

  ArticleItemWidget(this._articleItem, this._index);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(3.0)),
        ),
        elevation: 5.0,
        child: InkWell(
          child: Padding(
            padding: EdgeInsets.fromLTRB(10.0, 17.0, 12.0, 10.0),
            child: Row(
              children: <Widget>[
                // 左侧标题，时间，作者，以及分类
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // 第一行 标题
                      Text(
                        _articleItem.title,
                        maxLines: 2,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // 第二行 时间和作者
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                        child: Text(
                            '${_articleItem.niceDate} by ${_articleItem.author}'),
                      ),
                      // 第三行分类名称
                      Text(
                        _articleItem.superChapterName,
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Color(AppColors.AppThemeColor)),
                      ),
                    ],
                  ),
                ),

                // 右侧收藏按钮
//                InkWell(
//                  child: Column(
//                    mainAxisAlignment: MainAxisAlignment.end,
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    children: <Widget>[
//                      _articleItem.collect
//                          ? Icon(Icons.favorite, color: Colors.red)
//                          : Icon(Icons.favorite_border, color: null)
//                    ],
//                  ),
//                  // 收藏按钮点击事件
//                  onTap: () {
//                    debugPrint('colection$_index');
////                    _collectArticle(_articleItem);
//                  },
//                ),
              ],
            ),
          ),
          // item 点击事件
          onTap: () {
            // 跳转到文章详情界面
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ArticleDetailPage(_articleItem.title, _articleItem.link)));
          },
        ),
      ),
    );
  }

  /// 收藏
//  _collectArticle(ArticleModel article) {
//    ApiService().collect(article.id).then((result) {
//      debugPrint('result:$result');
//    });
//  }
}
