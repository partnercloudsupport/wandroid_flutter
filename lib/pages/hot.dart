import 'package:flutter/material.dart';
import 'package:wandroid_flutter/model/base_response.dart';
import 'package:wandroid_flutter/model/hot_key.dart';
import 'package:wandroid_flutter/model/hot_website.dart';
import 'package:wandroid_flutter/pages/article_detail.dart';
import 'package:wandroid_flutter/api/api_service.dart';
import 'package:wandroid_flutter/pages/search.dart';

class HotPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HotPageState();
}

class _HotPageState extends State<HotPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final _textColors = [
    0xFF41BAE9,
    0xFFF38083,
    0xFF828528,
    0xFF148583,
    0xFFF28317
  ];
  final _hotKeys = List<HotKeyModel>();
  final _hotWebsites = List<HotWebsiteModel>();

  @override
  void initState() {
    _onRefresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView(
          children: <Widget>[
            // 热词搜索
            Container(
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, bottom: 10.0, left: 14.0),
                      child: Text(
                        '热门搜索',
                        style: TextStyle(color: Colors.black, fontSize: 18.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1.0,
            ),
            // 热词列表
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
              child: Wrap(
                spacing: 10.0,
                children: _buildHotSearchWidgets(),
              ),
            ),
            Divider(
              height: 1.0,
            ),
            // 热门网站
            Container(
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, bottom: 10.0, left: 14.0),
                      child: Text(
                        '热门网站',
                        style: TextStyle(color: Colors.black, fontSize: 18.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1.0,
            ),
            // 热门网站列表
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
              child: Wrap(
                spacing: 10.0,
                children: _buildHotWebsiteWidgets(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// _buildHotSearchWidgets
  List<Widget> _buildHotSearchWidgets() {
    var _hotSearchWidgets = List<Widget>();
    for (var i = 0; i < _hotKeys.length; i++) {
      _hotSearchWidgets.add(
        ActionChip(
            label: Text(
              _hotKeys[i].name,
              style: TextStyle(color: Color(_textColors[i % 5])),
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => SearchPage(_hotKeys[i].name)));
            }),
      );
    }
    return _hotSearchWidgets;
  }

  /// _buildHotWebsiteWidgets
  List<Widget> _buildHotWebsiteWidgets() {
    var _hotWidgets = List<Widget>();
    for (var i = 0; i < _hotWebsites.length; i++) {
      _hotWidgets.add(
        ActionChip(
            label: Text(
              _hotWebsites[i].name,
              style: TextStyle(color: Color(_textColors[i % 5])),
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ArticleDetailPage(
                      _hotWebsites[i].name, _hotWebsites[i].link)));
            }),
      );
    }
    return _hotWidgets;
  }

  Future<Null> _onRefresh() async{
    _getHotKeys();
    _getHotWebsites();
    return null;
  }

  _getHotKeys() {
    ApiService().getHotKeys((BaseResponseList<HotKeyModel> res) {
      if (res != null) {
        _hotKeys.clear();
        _hotKeys.addAll(res.data);
      }
    });
  }

  _getHotWebsites() {
    ApiService().getHotWebsites((BaseResponseList<HotWebsiteModel> res) {
      if (res != null) {
        _hotWebsites.clear();
        _hotWebsites.addAll(res.data);
        debugPrint('res.length:${res.data.length}');
      }
    });
  }
}
