import 'package:flutter/material.dart';
import 'package:vball_stats/pages/MyAppBar.dart';
import 'CreatePlayerPopup.dart';
import 'package:vball_stats/entities/Team.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vball_stats/entities/Player.dart';
import 'package:vball_stats/globals.dart' as globals;


enum StatsType{
  MAIN_STATS,
  PASSING_STATS,
}

class PlayerStatsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PlayersStatsPageState();
}

class _PlayersStatsPageState extends State<PlayerStatsPage> {

  StatsType statsType = StatsType.MAIN_STATS;

  @override
  Widget build(BuildContext context) {
    List<Player> playerList = globals.currentTeam.playerList;

    switch (statsType){
      case StatsType.MAIN_STATS:
        return _makeMainStatsTable(playerList);
        break;
      case StatsType.PASSING_STATS:
        return _makePassingStatsTable(playerList);
        break;
    }

    
  }


  Widget _makePassingStatsTable(List<Player> playerList){
    return new SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: 
        new Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new DataTable(
            sortColumnIndex: 0,
            columns: [
              new DataColumn(label: new Text("Number")),
              new DataColumn(label: new Text("Player")),
              new DataColumn(label: new Text("Threes")),
              new DataColumn(label: new Text("Twos")),
              new DataColumn(label: new Text("Ones")),
              new DataColumn(label: new Text("Zeros")),
              new DataColumn(label: new Text("Average")),
            ],
            rows: <DataRow>[]+
              playerList.map((player) => DataRow(
                cells: [
                  DataCell(new Text(player.playerNumber)),
                  DataCell(new Text(player.name)),
                  DataCell(new Text(player.threes.toString())),
                  DataCell(new Text(player.twos.toString())),
                  DataCell(new Text(player.ones.toString())),
                  DataCell(new Text(player.zeros.toString())),
                  DataCell(new Text(((3*player.threes)+(2*player.twos)+(player.ones)+(player.zeros)).toString())),
                ]
              )).toList()
          ),
          new RaisedButton(
            child: new Text("Create new player"),
            onPressed: _makePlayerPopup,
          ),
          new RaisedButton(
            child: new Text("Switch to Main Stats"),
            onPressed: () {statsType = StatsType.MAIN_STATS;
            setState(() {
              
            });
            }
          )
        ],),
        
    );
  }

  Widget _makeMainStatsTable(List<Player> playerList){
    return new SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child:
            
    new Column(crossAxisAlignment: CrossAxisAlignment.start, children: [    
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
                  playerList
                      .map((player) => DataRow(
                    
                        cells: [
                            DataCell(new Text(player.playerNumber)),
                            DataCell(new Text(player.name),
                            onTap: () => _deletePlayerPopup(player),),
                            DataCell(new Text(player.kills.toString())),
                            DataCell(new Text(player.continues.toString())),
                            DataCell(new Text(player.blocks.toString())),
                            DataCell(new Text(player.errors.toString())),
                            DataCell(new Text(player.digs.toString())),
                            DataCell(new Text(player.aces.toString())),
                            DataCell(new Text(player.serveErrors.toString())),
                          ]))
                      .toList()),
          new RaisedButton(
            child: new Text("Create new player"),
            onPressed: _makePlayerPopup,
          ),
          new RaisedButton(
            child: new Text("Switch to Passing"),
            onPressed: () {
              statsType = StatsType.PASSING_STATS;
              setState(() {
                
              });
            })]));
  }

  void _makePlayerPopup() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return new AlertDialog(
            title: new Text("Create Player"),
            content: CreatePlayerPopup(),
          );
        }).then((_) => setState(() {}));
  }

  void _deletePlayerPopup(Player player){
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context){
        return new AlertDialog(
          title: new Text("Delete Player"),
          content: new Column(
            children: <Widget>[
              new Text("Do you want to delete this player?"),
              new RaisedButton(
                child: new Text("Yes"),
                onPressed: () => _deletePlayer(player),
              ),
              new RaisedButton(
                child: new Text("No"),
                onPressed:() => Navigator.pop(context),)
            ],
          ),
        );
      }
    ).then((_) => setState((){}));
  }

  void _deletePlayer(Player player){
    globals.currentTeam.playerList.remove(player);
    Firestore.instance.collection("Teams").document(globals.currentTeam.teamID).updateData(globals.currentTeam.toJson());
    Navigator.pop(context);
  }

}
