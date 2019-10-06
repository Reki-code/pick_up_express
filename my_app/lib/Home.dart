import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'NewHelp.dart';
import 'ProfileHome2.dart';
import 'SquareHome.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  final homeList = [SquareHome(), ProfileHome2()];
  int curIndex = 0;
  var iconOpacity = [1.0, 0.45];
  void onTap(int index) {
    setState(() {
      curIndex = index;

      iconOpacity = [0.45, 0.45];
      iconOpacity[index] = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      extendBody: true,
    //body: homeList[curIndex],
      body: IndexedStack(
        index: curIndex,
        children: homeList,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewHelp()),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 3.5,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Opacity(
              opacity: iconOpacity[0],
              child: IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  onTap(0);
                },
              ),
            ),
            Opacity(
              opacity: iconOpacity[1],
              child: IconButton(
                icon: Icon(Icons.person),
                onPressed: () {
                  onTap(1);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
