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

enum GamesPageState {
  CHOICES,
  DETAILS,
}

class AllGamesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AllGamesPageState();
}

class _AllGamesPageState extends State<AllGamesPage> {
  GamesPageState pageState = GamesPageState.CHOICES;
  Game chosenGame;

  @override
  Widget build(BuildContext context) {
    switch (pageState) {
      case GamesPageState.CHOICES:
        return _showGamesChoices();
      case GamesPageState.DETAILS:
        chosenGame.userTeamStatlines.statLineList.sort((a,b) => int.parse(a.player.playerNumber).compareTo(int.parse(b.player.playerNumber)));
        return _showGameDetails(chosenGame);
      default:
        return Container();
    }
  }

  Widget _showGamesChoices() {
    return new Center(
      child: new Column(
        children: <Widget>[] +
            globals.currentTeam.gamesList
                .map((game) => RaisedButton(
                      child: new Text(game.opposingTeam),
                      onPressed: (){setState(() {
                       pageState = GamesPageState.DETAILS; 
                       chosenGame = game;
                      });},
                      color: Colors.grey,
                    ))
                .toList(),
      ),
    );
  }

  Widget _showGameDetails(Game game) {
    return WillPopScope(
      onWillPop: () {setState(() {
       pageState = GamesPageState.CHOICES; 
      });},
      child:
    new SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child:
    new Column(children: <Widget>[
      new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
        child:
      new Text(
        "vs. " + game.opposingTeam,
        textAlign: TextAlign.center,
      )),
      new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      ),
      new Text(game.gameDate.toString()),
      _mainStatsTitle(),
        _playerStatsTable(game),
        _passingTitle(),
        _passingStatsTable(game)
    ])));
  }

  Widget _passingStatsTable(Game game){
    return new SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: 
      new Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new DataTable(
          sortColumnIndex: 0,
          sortAscending: true,
          columns: [
            new DataColumn(label: new Text("Number")),
            new DataColumn(label: new Text("Player")),
            new DataColumn(label: new Text("Thress")),
            new DataColumn(label: new Text("Twos")),
            new DataColumn(label: new Text("Ones")),
            new DataColumn(label: new Text("Zeros")),
            new DataColumn(label: new Text("Average")),
          ],
          rows: <DataRow>[]+
          game.userTeamStatlines.statLineList.map((statline) => DataRow(
            cells: [
              DataCell(new Text(statline.player.playerNumber)),
                  DataCell(new Text(statline.player.name)),
                  DataCell(new Text(statline.threes.toString())),
                  DataCell(new Text(statline.twos.toString())),
                  DataCell(new Text(statline.ones.toString())),
                  DataCell(new Text(statline.zeros.toString())),
                  DataCell(new Text(statline.getPassingAverage())),
            ]
          )).toList(),
        )]));
    }


  Widget _passingTitle(){
    return new Padding(
      padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
      child:
      new Text("Passing Stats",
      textAlign: TextAlign.center,
      style: new TextStyle(fontSize: 20.0),)
    );
  }

  Widget _mainStatsTitle(){
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 15.0),
      child: 
    new Text("Main Stats",
      textAlign: TextAlign.center,
      style: new TextStyle(fontSize: 20.0),));
  }

  Widget _playerStatsTable(Game game) {
    return new SingleChildScrollView( 
      scrollDirection: Axis.horizontal,
    child:
    new DataTable(
      sortColumnIndex: 0,
      columns: [
        new DataColumn(label: new Text("Number")),
        new DataColumn(label: new Text("Player")),
        new DataColumn(label: new Text("Kills")),
        new DataColumn(label: new Text("Continues")),
        new DataColumn(label: new Text("Blocks")),
        new DataColumn(label: new Text("Errors")),
        new DataColumn(label: new Text("Digs")),
        new DataColumn(label: new Text("Aces")),
        new DataColumn(label: new Text("Serve Errors")),
      ],
      rows: <DataRow>[] +
                  game.userTeamStatlines.statLineList
                      .map((statline) => DataRow(
                    
                        cells: [
                            DataCell(new Text(statline.player.playerNumber)),
                            DataCell(new Text(statline.player.name)),
                            DataCell(new Text(statline.kills.toString())),
                            DataCell(new Text(statline.continues.toString())),
                            DataCell(new Text(statline.blocks.toString())),
                            DataCell(new Text(statline.errors.toString())),
                            DataCell(new Text(statline.digs.toString())),
                            DataCell(new Text(statline.aces.toString())),
                            DataCell(new Text(statline.serveErrors.toString())),
                          ]))
                      .toList(),
    ));
  }
}
