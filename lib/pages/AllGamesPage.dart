import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vball_stats/pages/MyAppBar.dart';
import 'package:vball_stats/pages/PlayerStatsPage.dart';
import 'CreatePlayerPopup.dart';
import 'package:vball_stats/entities/Team.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vball_stats/entities/Player.dart';
import 'package:vball_stats/entities/Game.dart';
import 'package:vball_stats/globals.dart' as globals;


enum GamesPageState{
  CHOICES,
  DETAILS,
}

class AllGamesPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _AllGamesPageState();
}


class _AllGamesPageState extends State<AllGamesPage>{

  GamesPageState pageState = GamesPageState.CHOICES;

  @override
  Widget build(BuildContext context) {
    switch(pageState){
      case GamesPageState.CHOICES:
        return _showGamesChoices();
      case GamesPageState.DETAILS:
        return Container();
      default:
        return Container();
    }
  }

  Widget _showGamesChoices(){
    return new Center(
      child: new Column(
        children: <Widget>[]+
        globals.currentTeam.gamesList.map((game) => RaisedButton(
          child: new Text(game.opposingTeam),
          onPressed: null,
          color: Colors.grey,
        )).toList(),),
    );
  }
}