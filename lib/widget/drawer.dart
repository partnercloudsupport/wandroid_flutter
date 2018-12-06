import 'package:flutter/material.dart';
import 'package:wandroid_flutter/common/app_resource_config.dart';
import 'package:wandroid_flutter/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wandroid_flutter/model/user.dart';
import 'package:wandroid_flutter/pages/collect.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final _title = ['我喜欢的', '关于'];

  var _userId = 0;
  var _username = '';

  @override
  void initState() {
    _getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(width: 290.0),
      child: Material(
        elevation: 16.0,
        child: Container(
          decoration: BoxDecoration(color: Color(0xFFFFFFFF)),
          child: ListView.builder(
            itemBuilder: _buildListView,
            itemCount: _title.length + 1,
          ),
        ),
      ),
    );
  }

  /// _buildListView
  Widget _buildListView(BuildContext context, int index) {
    if (index == 0) {
      return Container(
        width: 290.0,
        height: 210.0,
        color: Color(AppColors.AppThemeColor),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                child: SizedBox(
                  width: 80.0,
                  height: 80.0,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                      _userId == 0
                          ? 'images/ic_avatar_default.png'
                          : 'images/ic_user.png',
                    ),
                  ),
                ),
                onTap: () {
                  _userId == 0
                      ? _login(context) // 去登录页
                      : _showAlertDialog(context); // 退出登录提醒
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Text(
                  _userId == 0 ? '点击头像登录' : _username,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    index -= 1;
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(_title[index]),
          trailing: Image.asset('images/ic_arrow_right.png',
              width: 30.0, height: 16.0),
          dense: true,
          onTap: () {
            if (index == 0) {
              _userId == 0
                  ? _login(context)
                  : Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                      CollectPage();
                    }));
            }
          },
        ),
        Divider(
          height: 1.0,
        ),
      ],
    );
  }

  _login(context) async {
    final result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginPage()));
    debugPrint('loginResult:$result');
    if (result != null) {
      var user = result as UserModel;
      if (user.id != null) {
        setState(() {
          _userId = user.id;
          if (user.username != null) {
            _username = user.username;
          }
        });
      }
    }
  }

  _getToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    int id = sp.get('id');
    String username = sp.get('username');
    if (id != null) {
      setState(() {
        _userId = id;
        if (username != null) {
          _username = username;
        }
      });
    }
  }

  /// 退出登录
  _logout() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('id');
    sp.remove('username');
    setState(() {
      _username = '';
      _userId = 0;
    });
  }

  /// _showAlertDialog
  _showAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('退出登录'),
              content: Text('确定退出登录？'),
              actions: <Widget>[
                FlatButton(
                  child: Text('取消'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('确定'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _logout();
                  },
                ),
              ],
            ));
  }
}
