import 'package:flutter/material.dart';

class HelpEachOtherInfo extends StatelessWidget {
  HelpEachOtherInfo();

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: Colors.white,
      elevation: 2.0,
      semanticContainer: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      child: Column(
        children: <Widget>[
          const ListTile(
            leading: Icon(Icons.access_time),
            title: Text(
              'The Enchanted Nightingale',
              style: TextStyle(color: Colors.black, fontSize: 40),
            ),
            subtitle: Text(
              'Music by Julie Gable. Lyrics by Sidney Steni.',
              style: TextStyle(color: Colors.yellow, fontSize: 16.0),
            ),
            contentPadding: EdgeInsets.all(20.0),
          ),
          ButtonTheme.bar(
            child: ButtonBar(
              children: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      
                    }, 
                    icon: Icon(Icons.settings_ethernet),
                    label: Text(
                      '帮取',
                      style: TextStyle(color: Colors.black, fontSize: 14.0),
                    ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
