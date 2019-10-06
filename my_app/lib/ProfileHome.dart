import 'package:data_plugin/bmob/bmob_query.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/DatabaseHandler.dart';

import 'Modal.dart';

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
        title: Text('个人中心'),
      ),
      body: FutureBuilder(
        future: DatabaseHandler.getCurrentUser(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return CircularProgressIndicator();
              break;
            case ConnectionState.done:
              if (snapshot.hasError) {
print(':::::::::::${snapshot.error}::::::::');
                return Center(
                  child: Text('网络错误'),
                );
              }
              if (snapshot.hasData) {
                return Profile(
                  userId: snapshot.data,
                );
              }
          }
          return Center(
            child: Text('loading'),
          );
        },
      ),
    );
  }

}

class UserInfoCard extends StatelessWidget {
  final String email;
  final String phoneNumber;
  final String address;

  UserInfoCard({this.email: '', this.phoneNumber: '', this.address: ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Card(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Profile extends StatelessWidget {
  final String userId;
  User user;
  Profile({this.userId});

  @override
  Widget build(BuildContext context) {
    void logout() {
      DatabaseHandler.saveLoginState(false);
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/authpage', ModalRoute.withName('/'));
    }

    BmobQuery().queryObjectByTableName(userId, '_User').then((json) {
      user = User.fromJson(json);
    });

    return ListView(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(0, 290.0, 0, 32.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16.0),
                  bottomRight: Radius.circular(16.0),
                ),
                color: Colors.blue,
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  height: 100.0,
                  margin: EdgeInsets.only(top: 90.0),
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(user.profileHead != null &&
                            user.profileHead.url != null
                        ? user.profileHead.url
                        : 'https://i.loli.net/2019/09/28/J3E6nefsKyj2zw1.jpg'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                ),
                Text(
                  user.username ?? '',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40.0),
                  padding: EdgeInsets.all(10.0),
//                    child: Card(
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceAround,
//                        children: <Widget>[
//                          Column(
//                            children: <Widget>[
//                              Container(
//                                padding: EdgeInsets.only(
//                                    top: 15.0, bottom: 5.0),
//                                child: Text(
//                                  '代取',
//                                  style: TextStyle(color: Colors.black54),
//                                ),
//                              ),
//                              Container(
//                                padding: EdgeInsets.only(bottom: 15.0),
//                                child: Text(
//                                  helpCount,
//                                  style: TextStyle(
//                                    color: Colors.black87,
//                                    fontSize: 16.0,
//                                  ),
//                                ),
//                              )
//                            ],
//                          ),
//                          Column(
//                            children: <Widget>[
//                              Container(
//                                padding: EdgeInsets.only(
//                                    top: 15.0, bottom: 5.0),
//                                child: Text(
//                                  '帮助',
//                                  style: TextStyle(color: Colors.black54),
//                                ),
//                              ),
//                              Container(
//                                padding: EdgeInsets.only(bottom: 15.0),
//                                child: Text(
//                                  helpOtherCount,
//                                  style: TextStyle(
//                                    color: Colors.black87,
//                                    fontSize: 16.0,
//                                  ),
//                                ),
//                              )
//                            ],
//                          ),
//                          Column(
//                            children: <Widget>[
//                              Container(
//                                padding: EdgeInsets.only(
//                                    top: 15.0, bottom: 5.0),
//                                child: Text(
//                                  '代取',
//                                  style: TextStyle(color: Colors.black54),
//                                ),
//                              ),
//                              Container(
//                                padding: EdgeInsets.only(bottom: 15.0),
//                                child: Text(
//                                  helpCount,
//                                  style: TextStyle(
//                                    color: Colors.black87,
//                                    fontSize: 16.0,
//                                  ),
//                                ),
//                              )
//                            ],
//                          ),
//                        ],
//                      ),
//                    ),
                )
              ],
            )
          ],
        ),
        UserInfoCard(
          email: user.email ?? '',
          phoneNumber: user.mobilePhoneNumber ?? '',
          address: user.address ?? '',
        ),
        FlatButton(
          color: Color.fromRGBO(250, 250, 250, 1.0),
          child: Text(
            '退出',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          onPressed: () {
            logout();
          },
        ),
        SizedBox(
          height: 20.0,
        ),
      ],
    );
  }
}
