import 'package:fluttertoast/fluttertoast.dart';
import 'package:data_plugin/bmob/response/bmob_registered.dart';
import 'package:data_plugin/bmob/table/bmob_user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_app/DatabaseHandler.dart';
import 'package:my_app/Modal.dart';

class AuthPage extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      image: DecorationImage(
                          image: NetworkImage('https://i.loli.net/2019/09/28/6p9ZhbqMX3J51Fl.jpg'),
                          fit: BoxFit.cover)
                    ),
                    foregroundDecoration: BoxDecoration(
                        color: Colors.blue.withAlpha(100)
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        Spacer(flex: 2,),
                        Text("已有帐号", style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                            color: Colors.white
                        ),),
                        SizedBox(height: 10.0),
                        SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)
                            ),
                            padding: const EdgeInsets.all(16.0),
                            color: Colors.white,
                            child: Text("登录", style: TextStyle(
                                color: Colors.blue
                            ),),
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginPage()),
                              );
                            },
                          ),
                        ),
                        Spacer()
                      ],
                    ),
                  ),
                ],
              ),),
            Expanded(child: Container(
              padding: const EdgeInsets.all(16.0),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white
              ),
              child: Column(
                children: <Widget>[
                  Spacer(),
                  Text("新用户?"),
                  SizedBox(height: 10.0),
                  SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      ),
                      padding: const EdgeInsets.all(16.0),
                      color: Colors.blue,
                      child: Text("注册", style: TextStyle(
                          color: Colors.white
                      ),),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignupPage()),
                        );
                      },
                    ),
                  ),
                  Spacer(flex: 2,)
                ],
              ),
            ),)
          ],
        ),
      ),
    );
  }
}

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

        Navigator.of(context).pushNamedAndRemoveUntil('/home', ModalRoute.withName('/'));
      }).catchError((e){
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
                          borderRadius: BorderRadius.circular(20.0)
                      ),
                      width: 70.0,
                      height: 20.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0),
                    child: Text(
                      "登录",
                      style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
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
// TODO: 忘记密码?
//            Container(
//                padding: const EdgeInsets.only(right: 16.0),
//                alignment: Alignment.centerRight,
//                child: Text("忘记密码?")),
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
        // TODO : save state
        DatabaseHandler.saveLoginState(true);
        DatabaseHandler.saveCurrentUser(data.objectId);
        Navigator.of(context).pushNamedAndRemoveUntil('/home', ModalRoute.withName('/'));
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
                      style:
                      TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
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
                      labelText: "确认密码",
                      hasFloatingPlaceholder: true),
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
                    _signUp(emailController.text, passwordController.text, usernameController.text);
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

  ProgressDialog({Key key, this.loading, this.child})
  :super(key: key);

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
      widgetList.add(
          Center(child: CircularProgressIndicator(),));
    }
    return Stack(
      children: widgetList,
    );
  }
  
}