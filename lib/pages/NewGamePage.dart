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




enum NewGameState{
  INIT,
  ONGOING,
  PASSING,
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
      case NewGameState.PASSING:
        return _passingPage();
      case NewGameState.ENDED:
        return _endGamePrompt();
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

  Widget _showSwitchToPassButton(){
    return new Padding(
      padding: EdgeInsets.fromLTRB(0.0, 0.0, 15.0, 0.0),
      child: new RaisedButton(
        child: new Text("Switch to passing"),
        onPressed: (){pageState = NewGameState.PASSING; setState(() {});},
      ),
    );
  }

  Widget _showSwitchToMainStatsButton(){
    return new Padding(
      padding: EdgeInsets.fromLTRB(0.0, 0.0, 15.0, 0.0),
      child: new RaisedButton(
        child: new Text("Switch to main stats"),
        onPressed: (){pageState = NewGameState.ONGOING; setState(() {});},
      ),
    );
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
      // globals.currentTeam.gamesList.add(currentGame);
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
              sortAscending: true,
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
      ),),
      _showSwitchToPassButton()]));
  }


  Widget _endGamePrompt(){
    return new Center(child:
    new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Text("Are you sure you would like to end this game?"),
        new RaisedButton(
          child: new Text("Yes"),
          onPressed: endGame,
          color: Colors.greenAccent,
        ),
        new RaisedButton(
          child: new Text("No"),
          onPressed:() {pageState = NewGameState.ONGOING; setState(() {});},
          color: Colors.redAccent,
        ),
        ],
    ));
  }


  Widget _passingPage(){
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
          currentGame.players.map((player) => DataRow(
            cells: [
              DataCell(new Text(player.playerNumber)),
                  DataCell(new Text(player.name)),
                  DataCell(new Text(player.threes.toString()),
                  onTap:(){player.threes++; setState(() {});}),
                  DataCell(new Text(player.twos.toString()),
                  onTap:(){player.twos++; setState(() {});}),
                  DataCell(new Text(player.ones.toString()),
                  onTap:(){player.ones++; setState(() {});}),
                  DataCell(new Text(player.zeros.toString()),
                  onTap:(){player.zeros++; setState(() {});}),
                  DataCell(new Text((((3*player.threes)+(2*player.twos)+(player.ones)+(player.zeros))
                  /(player.threes+player.twos+player.ones+player.zeros)).toStringAsFixed(2))),
            ]
          )).toList(),
        ),
        new Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: new RaisedButton(
        child: new Text("End Game"),
        onPressed: () {pageState = NewGameState.ENDED; setState(() {});},
      ),),
      _showSwitchToMainStatsButton()
      ],),
    );
  }

  void endGame(){
    globals.currentTeam.gamesList.add(currentGame);
    Firestore.instance.collection("Teams").document(globals.currentTeam.teamID).updateData(globals.currentTeam.toJson());
    setState(() {
     pageState = NewGameState.INIT; 
    });
  }
}