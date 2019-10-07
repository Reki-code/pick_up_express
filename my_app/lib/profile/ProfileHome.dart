import 'dart:async';

import 'package:data_plugin/bmob/bmob_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:my_app/data/DatabaseHandler.dart';
import 'package:my_app/data/Modal.dart';

class ProfileHome extends StatefulWidget {
  @override
  _ProfileHome createState() => _ProfileHome();
}

class _ProfileHome extends State<ProfileHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        title: Text('个人中心'),
      ),
      body: ProfileInfo(),
    );
  }
}

class ProfileInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfileInfo();
}

class _ProfileInfo extends State<ProfileInfo> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseHandler.getCurrentUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String user = snapshot.data;
          return UserInfo(user);
        } else if (snapshot.hasError) {
          return Center(
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: RaisedButton(
                    color: Colors.blue,
                    onPressed: () {
                      DatabaseHandler.saveLoginState(false);
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/authpage', ModalRoute.withName('/'));
                    },
                    child: Text(
                      '帐号状态异常,重新登录',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )),
          );
        }
        return Center(
          child: Column(
            children: <Widget>[CircularProgressIndicator(), Text('加载中')],
          ),
        );
      },
    );
  }
}

class UserInfo extends StatelessWidget {
  final String userId;

  UserInfo(this.userId);

  @override
  Widget build(BuildContext context) {
    void logout() {
      DatabaseHandler.saveLoginState(false);
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/authpage', ModalRoute.withName('/'));
    }

    return FutureBuilder(
        future: fetchUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User user = snapshot.data;
            return Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                EasyRefresh.custom(
                  slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Stack(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              height: 220.0,
                              color: Colors.white,
                            ),
                            ClipPath(
                              clipper: TopBarClipper(
                                  MediaQuery.of(context).size.width, 200.0),
                              child: new SizedBox(
                                width: double.infinity,
                                height: 200.0,
                                child: new Container(
                                  width: double.infinity,
                                  height: 240.0,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            GestureDetector(
                                child: Container(
                                  margin: EdgeInsets.only(top: 40.0),
                                  child: Center(
                                    child: Text(
                                      user.username ?? '',
                                      style: TextStyle(
                                          fontSize: 30.0, color: Colors.white),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  var textController = TextEditingController();
                                  showEditDialog(context, '修改用户名', () {
                                    user.username = textController.text;
                                    User()
                                      ..objectId = user.objectId
                                      ..username = textController.text
                                      ..save();
                                  }, textController);
                                }),
                            Container(
                              margin: EdgeInsets.only(top: 100.0),
                              child: Center(child: Container(
                                width: 100.0,
                                height: 100.0,
                                child: PreferredSize(
                                  child: GestureDetector(
                                    child: Container(
                                      child: ClipOval(
                                        child: Container(
                                          color: Colors.white,
                                          child: Image.network(
                                            user.profileHead != null &&
                                                    user.profileHead.url != null
                                                ? user.profileHead.url
                                                : 'https://i.loli.net/2019/09/28/J3E6nefsKyj2zw1.jpg',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  preferredSize: Size(80.0, 80.0),
                                ),
                              )),
                            ),
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          color: Colors.white,
                          padding: EdgeInsets.all(10.0),
                          child: Card(
                              color: Colors.blue,
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      '我的信息',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.0,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    Divider(
                                      color: Colors.black38,
                                    ),
                                    GestureDetector(
                                        child: ListTile(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 12.0, vertical: 4.0),
                                          leading: Icon(
                                            Icons.email,
                                            color: Colors.white,
                                          ),
                                          title: Text(
                                            '电子邮箱',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                            user.email ?? '',
                                            style: TextStyle(
                                                color: Colors.white70),
                                          ),
                                        ),
                                        onTap: () {
                                          var textController =
                                              TextEditingController();
                                          showEditDialog(context, '修改电子邮箱', () {
                                            user.email = textController.text;
                                            User()
                                              ..objectId = user.objectId
                                              ..email = textController.text
                                              ..save();
                                          }, textController);
                                        }),
                                    GestureDetector(
                                        child: ListTile(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 12.0, vertical: 4.0),
                                          leading: Icon(
                                            Icons.phone,
                                            color: Colors.white,
                                          ),
                                          title: Text(
                                            '电话',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                            user.mobilePhoneNumber ?? '',
                                            style: TextStyle(
                                                color: Colors.white70),
                                          ),
                                        ),
                                        onTap: () {
                                          var textController =
                                              TextEditingController();
                                          showEditDialog(context, '修改电话', () {
                                            user.mobilePhoneNumber =
                                                textController.text;
                                            User()
                                              ..objectId = user.objectId
                                              ..mobilePhoneNumber =
                                                  textController.text
                                              ..save();
                                          }, textController);
                                        }),
                                    GestureDetector(
                                        child: ListTile(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 12.0, vertical: 4.0),
                                          leading: Icon(
                                            Icons.location_on,
                                            color: Colors.white,
                                          ),
                                          title: Text(
                                            '地址',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                            user.address ?? '',
                                            style: TextStyle(
                                                color: Colors.white70),
                                          ),
                                        ),
                                        onTap: () {
                                          var textController =
                                              TextEditingController();
                                          showEditDialog(context, '修改地址', () {
                                            user.address = textController.text;
                                            User()
                                              ..objectId = user.objectId
                                              ..address = textController.text
                                              ..save();
                                          }, textController);
                                        }),
                                  ],
                                ),
                              )),
                        ),
                        Container(
                          width: double.infinity,
                          color: Colors.white,
                          padding: EdgeInsets.all(10.0),
                          child: FlatButton(
                            child: Text(
                              '退出',
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              logout();
                            },
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              ],
            );
          }
          return Center(
            child: Text('加载中'),
          );
        });
  }

  Future<User> fetchUserInfo() async {
    BmobQuery<User> query = BmobQuery();
    var completer = Completer<User>();
    User user;
    query.queryObjectByTableName(userId, '_User').then((json) {
      user = User.fromJson(json);
      completer.complete(user);
    });
    return completer.future;
  }

  showEditDialog(BuildContext context, String title, Function edit,
      TextEditingController textEditingController) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  child: TextFormField(
                    controller: textEditingController,
                  ),
                );
              },
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  '取消',
                  style: TextStyle(color: Colors.grey),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('修改'),
                onPressed: () {
                  edit();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}

class TopBarClipper extends CustomClipper<Path> {
  double width;
  double height;

  TopBarClipper(this.width, this.height);

  @override
  Path getClip(Size size) => Path()
    ..moveTo(0.0, 0.0)
    ..lineTo(width, 0.0)
    ..lineTo(width, height / 2)
    ..lineTo(0.0, height);

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
