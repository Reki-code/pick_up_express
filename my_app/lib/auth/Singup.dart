import 'package:data_plugin/bmob/response/bmob_registered.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_app/data/DatabaseHandler.dart';
import 'package:my_app/data/Modal.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPage createState() => _SignupPage();
}

class _SignupPage extends State<SignupPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    void _signUp(String email, String password, String username) {
      _loading = true;
      User user = User();
      user.username = usernameController.text;
      user.password = passwordController.text;
      user.email = emailController.text;
      user.register().then((BmobRegistered data) {
        DatabaseHandler.saveLoginState(true);
        DatabaseHandler.saveCurrentUser(data.objectId);
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', ModalRoute.withName('/'));
      }).catchError((e) {
        // singup failure
        _loading = false;
        print(e.toString());
        Fluttertoast.showToast(
          msg: '用户名已存在',
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
              const SizedBox(height: 80.0),
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
                      "注册",
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
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: "电子邮箱", hasFloatingPlaceholder: true),
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
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 32, vertical: 8.0),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: "确认密码", hasFloatingPlaceholder: true),
                  validator: (value) {
                    if (value != passwordController.text) {
                      return '密码不一致';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 60.0),
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
                    _signUp(emailController.text, passwordController.text,
                        usernameController.text);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "注册",
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

class ProgressDialog extends StatelessWidget {
  final bool loading;
  final Widget child;

  ProgressDialog({Key key, this.loading, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(child);
    if (loading) {
      widgetList.add(Opacity(
        opacity: 0.8,
        child: ModalBarrier(
          color: Colors.black87,
        ),
      ));
      widgetList.add(Center(
        child: CircularProgressIndicator(),
      ));
    }
    return Stack(
      children: widgetList,
    );
  }
}
