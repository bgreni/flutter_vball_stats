import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vball_stats/pages/MyAppBar.dart';
import 'CreatePlayerPopup.dart';
import 'package:vball_stats/entities/Team.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vball_stats/entities/Player.dart';
import 'package:vball_stats/entities/Game.dart';
import 'package:vball_stats/globals.dart' as globals;




enum NewGameState{
  INIT,
  ONGOING,
  ENDED,
}

class NewGamePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _NewGamePageState();
}


class _NewGamePageState extends State<NewGamePage> {
  final _formKey = new GlobalKey<FormState>();
  String _opposingTeamName;
  Game currentGame;

  NewGameState pageState = NewGameState.INIT;

  @override
  Widget build(BuildContext context) {
    switch (pageState){
      case NewGameState.INIT:
        return _newGameCreation();
      case NewGameState.ONGOING:
        return _statsPage();
      case NewGameState.ENDED:
        return null;
    }
 
  }


  Widget _newGameCreation(){
    return new Form(
      key: _formKey,
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _teamNameInput(),
          _showConfirmButton(),

        ],)
    );
  }


  Widget _teamNameInput(){
    return new Padding(
      padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: "Opposing Team Name",
          icon: new Icon(
            Icons.text_fields,
            color: Colors.grey
          )
        ),
        validator: (value) => value.isEmpty ? "Must enter team name" : null,
        onSaved: (value) => _opposingTeamName = value,
      )
    );
  }

  Widget _showConfirmButton(){
    return new Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new RaisedButton(
        child: new Text("Confirm"),
        onPressed: _validateAndSave,),);
  }

  void _validateAndSave(){
    final _form = _formKey.currentState;
    if(_form.validate()){
      _form.save();
      List<Player> players = globals.currentTeam.resetPlayerStats();
      currentGame = new Game(userTeam: globals.currentTeam.teamName,
      opposingTeam: _opposingTeamName, 
      gameDate: DateTime.now(),
      players: players);
      globals.currentTeam.gamesList.add(currentGame);
      pageState = NewGameState.ONGOING;

      setState(() {
        
      });
    }
  }



  Widget _statsPage(){
  

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
                  currentGame.players
                      .map((player) => DataRow(
                    
                        cells: [
                            DataCell(new Text(player.playerNumber)),
                            DataCell(new Text(player.name)),
                            DataCell(new Text(player.kills.toString()),
                            onTap: (){player.kills++; setState(() {});}),
                            DataCell(new Text(player.continues.toString()),
                            onTap: (){player.continues++; setState(() {});}),
                            DataCell(new Text(player.blocks.toString()),
                            onTap: (){player.blocks++; setState(() {});}),
                            DataCell(new Text(player.errors.toString()),
                            onTap: (){player.errors++; setState(() {});}),
                            DataCell(new Text(player.digs.toString()),
                            onTap: (){player.digs++; setState(() {});}),
                            DataCell(new Text(player.aces.toString()),
                            onTap: (){player.aces++; setState(() {});}),
                            DataCell(new Text(player.serveErrors.toString()),
                            onTap: (){player.serveErrors++; setState(() {});}),
                          ]))
                      .toList()),
    new Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: new RaisedButton(
        child: new Text("End Game"),
        onPressed: () {pageState = NewGameState.ENDED; setState(() {});},
      ),)]));
  }


  // TODO: MAKE ENDED PAGE A THINGs
}