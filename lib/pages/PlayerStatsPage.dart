import 'package:flutter/material.dart';
import 'package:vball_stats/pages/MyAppBar.dart';
import 'CreatePlayerPopup.dart';


class PlayerStatsPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _PlayersStatsPageState();

}

class _PlayersStatsPageState extends State<PlayerStatsPage>{


  @override
  Widget build(BuildContext context) {
      return new Column(
        children: <Widget>[
          new RaisedButton(
            child: new Text("Create new player"),
            onPressed: _makePlayerPopup,
          )
        ],
      );
  }

  void _makePlayerPopup(){
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context){
      new AlertDialog(
      title: new Text("Create Player"),
      content: CreatePlayerPopup(),
    );
      }
    );
  }

}