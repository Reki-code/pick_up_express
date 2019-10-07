import 'package:data_plugin/bmob/table/bmob_user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_app/auth/Singup.dart';
import 'package:my_app/data/DatabaseHandler.dart';
import 'package:my_app/data/Modal.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    void _login(String name, String password) {
      _loading = true;
      User user = User();
      user.username = usernameController.text;
      user.password = passwordController.text;
      user.login().then((BmobUser bmobUser) {
        DatabaseHandler.saveLoginState(true);
        DatabaseHandler.saveCurrentUser(bmobUser.objectId);

        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', ModalRoute.withName('/'));
      }).catchError((e) {
        // login failure
        print(e);
        _loading = false;
        passwordController.text = "";
        Fluttertoast.showToast(
          msg: '用户名或密码错误',
          gravity: ToastGravity.BOTTOM,
        );
      });
    }

    return ProgressDialog(
      loading: _loading,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 100.0),
              Stack(
                children: <Widget>[
                  Positioned(
                    left: 20.0,
                    top: 15.0,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20.0)),
                      width: 70.0,
                      height: 20.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0),
                    child: Text(
                      "登录",
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 32, vertical: 8.0),
                child: TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                      labelText: "用户名", hasFloatingPlaceholder: true),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 32, vertical: 8.0),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                      labelText: "密码", hasFloatingPlaceholder: true),
                ),
              ),
              const SizedBox(height: 120.0),
              Align(
                alignment: Alignment.centerRight,
                child: RaisedButton(
                  padding: const EdgeInsets.fromLTRB(40.0, 16.0, 30.0, 16.0),
                  color: Colors.blue,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0))),
                  onPressed: () {
                    _login(usernameController.text, passwordController.text);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "登录",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                      const SizedBox(width: 40.0),
                      Icon(
                        Icons.arrow_forward,
                        size: 18.0,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}