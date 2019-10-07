import 'package:flutter/material.dart';
import 'package:my_app/announcement/Announcement.dart';

class SquareHome extends StatefulWidget {
  const SquareHome() : super();

  @override
  State<StatefulWidget> createState() => _SquareHome();
}

class _SquareHome extends State {
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            leading: Icon(Icons.home),
            primary: true,
            forceElevated: false,
            automaticallyImplyLeading: false,
            titleSpacing: NavigationToolbar.kMiddleSpacing,
            expandedHeight: 200,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                '代取广场',
                style: TextStyle(fontSize: 16.0),
              ),
              background: Image.network(
                'https://i.loli.net/2019/09/28/gW47kxyuvKEs1n5.jpg',
                fit: BoxFit.cover,
              ),
            ),
          )
        ];
      },
      body: Announcement(),
    );
  }
}
