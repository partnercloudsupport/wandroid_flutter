import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wandroid_flutter/api/api_service.dart';
import 'package:wandroid_flutter/model/base_response.dart';
import 'package:wandroid_flutter/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 登录页
class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _isRequesting = false;
  var _username = '';
  var _password = '';

  var _usernameController = TextEditingController();
  var _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          '用户登录',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 48.0, left: 32.0, right: 32.0, bottom: 190.0),
            child: Card(
              child: _isRequesting == true
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                            Theme.of(context).primaryColor),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(top: 28.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 80.0,
                            height: 80.0,
                            child: CircleAvatar(
                              backgroundImage: AssetImage(
                                "images/ic_avatar_default.png",
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 18.0),
                            child: TextField(
                              maxLines: 1,
                              onChanged: (username) {
                                _username = username;
                              },
//                              autofocus: true,
                              decoration: InputDecoration(
                                  hintText: "账 号：", labelText: "请输入您的账号"),
                              controller: _usernameController,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 12.0),
                            child: TextField(
                              maxLines: 1,
                              onChanged: (password) {
                                _password = password;
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: "密 码：", labelText: "请输入您的密码"),
                              controller: _passwordController,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 17.0, left: 17.0, top: 40.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: RaisedButton(
                                  color: Theme.of(context).primaryColor,
                                  child: Text(
                                    "登 录",
                                    style: TextStyle(
                                        fontSize: 14.0, color: Colors.white),
                                  ),
                                  onPressed: () {
                                    _login();
                                  },
                                )),
                                Container(
                                  width: 17.0,
                                ),
                                Expanded(
                                    child: RaisedButton(
                                  color: Theme.of(context).primaryColor,
                                  child: Text(
                                    "注 册",
                                    style: TextStyle(
                                        fontSize: 14.0, color: Colors.white),
                                  ),
                                  onPressed: () {
                                    _register();
                                  },
                                ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  _setToken(int id, String username) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt('id', id);
    sp.setString('username', username);
  }

  /// login
  _login() {
    if (_checkInput()) {
      var params = Map<String, String>();
      params["username"] = _username;
      params["password"] = _password;
//      params["repassword"] = _password;
      setState(() {
        _isRequesting = true;
      });
      ApiService().login(_username, _password).then((res) {
        debugPrint('user:' + res.toString());
        setState(() {
          _isRequesting = false;
        });
        BaseResponse<UserModel> data = BaseResponse<UserModel>.fromJson(
            res.data, (r) => UserModel.fromJson(r));
        if (data != null && data.data != null) {
          var id = data.data.id;
          var username = data.data.username;
          if (id == null || id == 0) {
            return;
          }
          _setToken(id, username);
          Navigator.of(context).pop(data.data);
        }
      });
    }
  }

  /// register
  _register() {}

  /// _checkInput
  bool _checkInput() {
    if (_username.isEmpty || _password.isEmpty) {
      Fluttertoast.showToast(
          msg: _username.isEmpty ? '请输入您的账号' : '请输入您的密码',
          gravity: ToastGravity.CENTER,
          bgcolor: "#99000000",
          textcolor: '#ffffff');
      return false;
    }
    if (_username.length < 8 || _password.length < 8) {
      Fluttertoast.showToast(
          msg: _username.length < 8 ? '请输入不少于8位长度的账号' : '请输入不少于8位长度的密码',
          gravity: ToastGravity.CENTER,
          bgcolor: "#99000000",
          textcolor: '#ffffff');
      return false;
    }
    return true;
  }
}
