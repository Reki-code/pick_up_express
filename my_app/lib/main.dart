import 'package:data_plugin/bmob/bmob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/auth/Auth.dart';
import 'package:my_app/data/DatabaseHandler.dart';
import 'package:my_app/Home.dart';

Future main() async {
  DatabaseHandler.getLoginState().then((isLogin) {
    runApp(MyApp(isLogin));
  });
}

class MyApp extends StatelessWidget {
  bool isLogin;
  var page = [AuthPage(), Home()];

  MyApp(this.isLogin);

  int pageNumber() {
    return isLogin ? 1 : 0;
  }

  @override
  Widget build(BuildContext context) {
    /**
    * 超级权限非加密方式初始化
    */
    // 在下面填写 Bmob 相关 api key
    Bmob.initMasterKey("appId","apiKey","masterKey");

    return MaterialApp(
      title: 'pa',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: page[pageNumber()],
      routes: <String, WidgetBuilder>{
        '/authpage': (BuildContext context) => AuthPage(),
        '/home': (BuildContext context) => Home(),
      },
    );
  }
}
