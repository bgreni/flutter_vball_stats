import 'package:flutter/material.dart';
import 'CreatePlayerPopup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vball_stats/entities/Player.dart';
import 'package:vball_stats/widgets/WidgetFactory.dart';
import 'package:vball_stats/globals.dart' as globals;

enum StatsType {
  MAIN_STATS,
  PASSING_STATS,
  GAME_AVERAGES,
}

class PlayerStatsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PlayersStatsPageState();
}

class _PlayersStatsPageState extends State<PlayerStatsPage> {
  StatsType statsType = StatsType.MAIN_STATS;

  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _modeSelectionDropdown(),
        _pickPageMode(),
      ],
    );
    
  }

  Widget _pickPageMode() {
    switch (statsType) {
      case StatsType.MAIN_STATS:
        return _makeMainStatsTable();
        break;
      case StatsType.PASSING_STATS:
        return _makePassingStatsTable();
        break;
      case StatsType.GAME_AVERAGES:
        return _makeGameAveragesTable();
        break;
    }
  }

  Widget _makePassingStatsTable() {
  
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
        ],
      ),
    );
  }

  Widget _makeMainStatsTable() {
    
    return new SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child:
            new Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          WidgetFactory.createImmutableStatsTable(globals.currentTeam.getPlayerTotals()),
          _createNewPlayerButton(),
        ]));
  }

  Widget _modeSelectionDropdown() {
    return DropdownButton<dynamic>(
      value: statsType,
      onChanged: (newMode) {
        setState(() {
          statsType = newMode;
        });
      },
      items: StatsType.values
        .map<DropdownMenuItem<dynamic>>((currentMode) {
          return DropdownMenuItem<dynamic>(
            value: currentMode,
            child: new Text(currentMode.toString().split(".").last.split("_").join(" ").toLowerCase()),
          );
        }).toList(),
    );
  }

  Widget _makeGameAveragesTable() {
    return new SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: 
        new Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          WidgetFactory.createGameAveragesTable(globals.currentTeam),
          _createNewPlayerButton(),
        ],),
    );
  }

  Widget _createNewPlayerButton() {
    return new RaisedButton(
            child: new Text("Create new player"),
            onPressed: _makePlayerPopup,
          );
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
