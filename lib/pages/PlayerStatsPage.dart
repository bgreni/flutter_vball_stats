import 'package:flutter/material.dart';
import 'package:vball_stats/pages/MyAppBar.dart';
import 'CreatePlayerPopup.dart';
import 'package:vball_stats/entities/Team.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vball_stats/entities/Player.dart';
import 'package:vball_stats/globals.dart' as globals;

class PlayerStatsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PlayersStatsPageState();
}

class _PlayersStatsPageState extends State<PlayerStatsPage> {
  @override
  Widget build(BuildContext context) {
    List<Player> playerList = globals.currentTeam.playerList;
    playerList.forEach((player) => print(player.name));

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
          )
        ]));
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
    Navigator.pop(context);
    //Firestore.instance.collection("Teams").document(globals.currentTeam.teamID).collection("playerList");
  }

}
