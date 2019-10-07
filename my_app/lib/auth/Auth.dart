import 'package:flutter/material.dart';
import 'package:my_app/auth/Login.dart';
import 'package:my_app/auth/Singup.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                            image: NetworkImage(
                                'https://i.loli.net/2019/09/28/6p9ZhbqMX3J51Fl.jpg'),
                            fit: BoxFit.cover)),
                    foregroundDecoration:
                        BoxDecoration(color: Colors.blue.withAlpha(100)),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        Spacer(
                          flex: 2,
                        ),
                        Text(
                          "已有帐号",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                              color: Colors.white),
                        ),
                        SizedBox(height: 10.0),
                        SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            padding: const EdgeInsets.all(16.0),
                            color: Colors.white,
                            child: Text(
                              "登录",
                              style: TextStyle(color: Colors.blue),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                              );
                            },
                          ),
                        ),
                        Spacer()
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Text("新用户?"),
                    SizedBox(height: 10.0),
                    SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        padding: const EdgeInsets.all(16.0),
                        color: Colors.blue,
                        child: Text(
                          "注册",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupPage()),
                          );
                        },
                      ),
                    ),
                    Spacer(
                      flex: 2,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
