import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

/// 文章详情
class ArticleDetailPage extends StatefulWidget {
  final String _title;
  final String _articleLink;

  ArticleDetailPage(this._title, this._articleLink);

  @override
  State<StatefulWidget> createState() =>
      _ArticleDetailPageState(_title, _articleLink);
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  final String _title;
  final String _articleLink;

  _ArticleDetailPageState(this._title, this._articleLink);

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: _articleLink,
      withJavascript: true,
      withZoom: true,
      appBar: AppBar(
        title: Text(
          _title,
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
    );
  }
}
