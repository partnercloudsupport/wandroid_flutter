import 'package:flutter/material.dart';
import 'package:wandroid_flutter/pages/category_article_list.dart';
import 'package:wandroid_flutter/model/category_model.dart';

/// CategoryTabPage
class CategoryTabPage extends StatefulWidget {
  final _categoryModel;

  CategoryTabPage(this._categoryModel);

  @override
  State<StatefulWidget> createState() => _CategoryTabPage(_categoryModel);
}

class _CategoryTabPage extends State<CategoryTabPage> {
  var _title;
  final _tabs = List<Tab>();
  final CategoryModel _categoryModel;
  final _tabViews = List<Widget>();

  _CategoryTabPage(this._categoryModel);

  @override
  void initState() {
    _title = _categoryModel.name;
    _tabs.clear();
    for (var item in _categoryModel.children) {
      _tabs.add(Tab(
        child: Text(
          item.name,
          style: TextStyle(color: Colors.white),
        ),
      ));
      _tabViews.add(CategoryArticleListPage(item.id));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            _title,
            style: TextStyle(color: Colors.white),
          ),
          bottom: TabBar(
            tabs: _tabs,
            indicatorColor: Colors.white,
            isScrollable: true,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: TabBarView(children: _tabViews),
      ),
    );
  }
}
