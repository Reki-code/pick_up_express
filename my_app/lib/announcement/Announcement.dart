import 'dart:async';

import 'package:data_plugin/bmob/bmob_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/bezier_bounce_footer.dart';
import 'package:flutter_easyrefresh/delivery_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:my_app/data/Modal.dart';

class Announcement extends StatefulWidget {
  @override
  _Announcement createState() => _Announcement();
}

class _Announcement extends State<Announcement> {
  Future announcementData = fetchAnnouncementInfo();

  Future _refresh() async {
    print('refresh:');
    setState(() {
      announcementData = fetchAnnouncementInfo();
    });
    return;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: announcementData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var list = snapshot.data;
          if (list.length != 0) {
            return Center(
                child: EasyRefresh.custom(
                    firstRefresh: true,
                    firstRefreshWidget: Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: SizedBox(
                        height: 200.0,
                        width: 200.0,
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  width: 50.0,
                                  height: 50.0,
                                  child: SpinKitThreeBounce(
                                    color: Theme.of(context).primaryColor,
                                    size: 25.0,
                                  )),
                              Container(
                                child: Text('加载中'),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    header: DeliveryHeader(
                      backgroundColor: Colors.grey[100],
                    ),
                    onRefresh: _refresh,
                    slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return AnnouncementInfo(list[index]);
                      },
                      childCount: list.length,
                    ),
                  ),
                ]));
          } else if (list.length == 0) {
            return Center(child: RefreshIndicator(
              onRefresh: _refresh,
              child: ListView.builder(
                padding: EdgeInsets.all(6.0),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
//              return HelpEachOtherInfo(listData[index]);
                  return Card(
                    child: Text('没有公告'),
                  );
                },
                itemCount: 1,
              ),
            ));
          }
        } else if (snapshot.hasError) {
          return Center(child: RefreshIndicator(
            onRefresh: _refresh,
            child: Text(
              '加载失败',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ));
        }
        return Center(child: RefreshIndicator(
          onRefresh: _refresh,
          child: Center(
            child: Column(
              children: <Widget>[CircularProgressIndicator(), Text('加载中')],
            ),
          ),
        ));
      },
    );
  }

  static Future<List<bulletinBoard>> fetchAnnouncementInfo() async {
    BmobQuery<bulletinBoard> query = BmobQuery();
    query.limit = 10;
    var completer = Completer<List<bulletinBoard>>();
    var bbList = List<bulletinBoard>();
    query.queryObjectsByTableName('bulletinBoard').then((jsonList) {
      for (var json in jsonList) {
        bbList.add(bulletinBoard.fromJson(json));
      }
      completer.complete(bbList);
    });
    return completer.future;
  }
}

class AnnouncementInfo extends StatelessWidget {
  final bulletinBoard bbInfo;

  AnnouncementInfo(this.bbInfo);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: Colors.white,
      elevation: 2.0,
      margin: EdgeInsets.only(top: 8.0, left: 10.0, right: 10.0),
      semanticContainer: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.announcement),
            title: Text(bbInfo.title ?? ''),
            subtitle: Text(bbInfo.content ?? ''),
            contentPadding: EdgeInsets.all(20.0),
          )
        ],
      ),
    );
  }
}
