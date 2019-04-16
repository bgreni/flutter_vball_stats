import 'package:flutter/material.dart';
import 'package:vball_stats/pages/MyAppBar.dart';
import 'CreatePlayerPopup.dart';
import 'package:vball_stats/entities/Team.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vball_stats/entities/Player.dart';


class PlayerStatsPage extends StatefulWidget{

  final Team team;
  PlayerStatsPage({this.team});

  @override
  State<StatefulWidget> createState() => _PlayersStatsPageState();

}

class _PlayersStatsPageState extends State<PlayerStatsPage>{


  @override
  Widget build(BuildContext context) {
  
      List<Player> playerList = widget.team.playerList;

      return new Column(
        children: <Widget>[
          new ListView.builder(
            shrinkWrap: true,
            itemCount: playerList.length,
            itemBuilder: (BuildContext context, int index){
              new Row(
                children: <Widget>[
                  new Text(playerList[index].name)
                ],
              );
            }
          ),
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
      return new AlertDialog(
      title: new Text("Create Player"),
      content: CreatePlayerPopup(),
    );
      }
    );
    this.setState((){});
  }

}