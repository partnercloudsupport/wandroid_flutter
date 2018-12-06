import 'package:flutter/material.dart';
import 'package:wandroid_flutter/pages/category.dart';
import 'package:wandroid_flutter/pages/discovery.dart';
import 'package:wandroid_flutter/pages/home.dart';
import 'package:wandroid_flutter/pages/hot.dart';
import 'package:wandroid_flutter/common/app_resource_config.dart';
import 'package:wandroid_flutter/pages/search.dart';
import 'package:wandroid_flutter/widget/drawer.dart';

void main() => runApp(new WanAndroidApp());

class WanAndroidApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WanAndroidAppState();
}

class _WanAndroidAppState extends State<WanAndroidApp> {
  final _bottomTitle = ['首页', '体系', '热门'];
  final _bottomIcon = [
    [
      _getImage('images/ic_nav_news_normal.png'),
      _getImage('images/ic_nav_news_actived.png')
    ],
    [
      _getImage('images/ic_nav_tweet_normal.png'),
      _getImage('images/ic_nav_tweet_actived.png')
    ],
//    [
//      _getImage('images/ic_nav_discover_normal.png'),
//      _getImage('images/ic_nav_discover_actived.png')
//    ],
    [
      _getImage('images/ic_nav_my_normal.png'),
      _getImage('images/ic_nav_my_pressed.png')
    ]
  ];

  static _getImage(path) => Image.asset(path, width: 20.0, height: 20.0);

  var _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(AppColors.AppThemeColor),
      ),
      // 添加build 是因为   Navigator.of(context).push 中的context报错
      home: Builder(
        builder: (context) => Scaffold(
              appBar: AppBar(
                title: Text(_bottomTitle[_tabIndex],
                    style: TextStyle(color: Colors.white)),
                iconTheme: IconThemeData(color: Colors.white),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      debugPrint('print search');
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SearchPage('')));
                    },
                  )
                ],
              ),
              drawer: MyDrawer(),
              body: IndexedStack(
                children: <Widget>[
                  HomePage(),
                  CategoryPage(),
//            DiscoveryPage(),
                  HotPage(),
                ],
                index: _tabIndex,
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                items: _getBottomNaviItems(),
                currentIndex: _tabIndex,
                onTap: (index) => setState(() {
                      _tabIndex = index;
                    }),
              ),
            ),
      ),
    );
  }

  /// _getBottomNaviItems
  List<BottomNavigationBarItem> _getBottomNaviItems() {
    var list = List<BottomNavigationBarItem>();
    for (int i = 0; i < _bottomTitle.length; i++) {
      list.add(BottomNavigationBarItem(
        icon: _getBottomIcon(i),
        title: _getBottomText(i),
      ));
    }
    return list;
  }

  /// _getBottomIcon
  Image _getBottomIcon(index) =>
      index == _tabIndex ? _bottomIcon[index][1] : _bottomIcon[index][0];

  /// _getBottomText
  Text _getBottomText(index) => index == _tabIndex
      ? Text(_bottomTitle[index],
          style: TextStyle(
              color: Color(AppColors.BottomNavigationBarSelectedColor)))
      : Text(_bottomTitle[index],
          style: TextStyle(
              color: Color(AppColors.BottomNavigationBarUnselectedColor)));
}
