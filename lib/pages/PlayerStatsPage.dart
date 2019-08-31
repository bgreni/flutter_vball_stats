import 'package:flutter/material.dart';
import 'package:vball_stats/pages/MyAppBar.dart';
import 'CreatePlayerPopup.dart';
import 'package:vball_stats/entities/Team.dart';
import 'package:vball_stats/entities/Roster.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vball_stats/entities/Player.dart';
import 'package:vball_stats/widgets/WidgetFactory.dart';
import 'package:vball_stats/globals.dart' as globals;

enum StatsType {
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
    List<Player> playerList = globals.currentTeam.roster.playerList;
    playerList.sort((a,b) => int.parse(a.playerNumber).compareTo(int.parse(b.playerNumber)));

    switch (statsType) {
      case StatsType.MAIN_STATS:
        return _makeMainStatsTable(playerList);
        break;
      case StatsType.PASSING_STATS:
        return _makePassingStatsTable(playerList);
        break;
    }
  }

  Widget _makePassingStatsTable(List<Player> playerList) {
  
    return new SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          WidgetFactory.createImmutablePassingTable(globals.currentTeam.getPlayerTotals()),
          new RaisedButton(
            child: new Text("Create new player"),
            onPressed: _makePlayerPopup,
          ),
          new RaisedButton(
              child: new Text("Switch to Main Stats"),
              onPressed: () {
                statsType = StatsType.MAIN_STATS;
                setState(() {});
              })
        ],
      ),
    );
  }

  Widget _makeMainStatsTable(List<Player> playerList) {
    
    return new SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child:
            new Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          WidgetFactory.createImmutableStatsTable(globals.currentTeam.getPlayerTotals()),
          new RaisedButton(
            child: new Text("Create new player"),
            onPressed: _makePlayerPopup,
          ),
          new RaisedButton(
              child: new Text("Switch to Passing"),
              onPressed: () {
                statsType = StatsType.PASSING_STATS;
                setState(() {});
              })
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

  void _deletePlayerPopup(Player player) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
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
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
          );
        }).then((_) => setState(() {}));
  }

  void _deletePlayer(Player player) {
    globals.currentTeam.roster.playerList.remove(player);
    Firestore.instance
        .collection("Teams")
        .document(globals.currentTeam.teamID)
        .updateData(globals.currentTeam.toJson());
    Navigator.pop(context);
  }
}
