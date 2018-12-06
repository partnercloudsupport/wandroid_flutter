import 'package:flutter/material.dart';
import 'package:wandroid_flutter/api/api_service.dart';
import 'package:wandroid_flutter/model/base_response.dart';
import 'package:wandroid_flutter/model/category_model.dart';
import 'package:wandroid_flutter/common/app_resource_config.dart';
import 'package:wandroid_flutter/pages/category_tab.dart';

/// 知识体系
class CategoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  final _treeData = List<CategoryModel>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _getTreeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _treeData.length == 0
        ? Center(child: Text('no data'))
        : RefreshIndicator(
            onRefresh: _onRefresh,
            child: ListView.builder(
              itemBuilder: (context, index) => _buildListView(context, index),
              itemCount: _treeData.length,
            ),
          );
  }

  /// _buildListView
  Widget _buildListView(BuildContext context, int index) {
    var _treeItem = _treeData[index];

    // _getSubTitleData
    String _getSubTitleData() {
      var sb = StringBuffer();
      for (var item in _treeItem.children) {
        sb.write('${item.name}     ');
      }
      return sb.toString();
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(3.0),
          ),
        ),
        child: ListTile(
          title: Text(
            _treeItem.name,
            softWrap: true,
            maxLines: 10,
            style: TextStyle(
              fontSize: 16.0,
              color: Color(AppColors.AppThemeColor),
            ),
          ),
          subtitle: Text(_getSubTitleData()),
          trailing: Icon(Icons.arrow_right),
          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          onTap: () {
            debugPrint('resd$index');
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CategoryTabPage(_treeItem)));
          },
        ),
      ),
    );
  }

  /// refresh
  Future<Null> _onRefresh() async{
    _getTreeData();
    return null;
  }

  /// 获取知识体系数据
  _getTreeData() {
    ApiService().getCategoryTree((BaseResponseList<CategoryModel> res) {
      debugPrint('res====${res.data}');
      if (res != null || res.data != null) {
        setState(() {
          _treeData.clear();
          _treeData.addAll(res.data);
        });
      }
    });
  }
}
