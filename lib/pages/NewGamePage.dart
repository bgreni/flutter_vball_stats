import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:vball_stats/entities/Game.dart';
import 'package:vball_stats/entities/StatLines.dart';
import 'package:vball_stats/entities/Roster.dart';
import 'package:vball_stats/entities/Set.dart';
import 'package:vball_stats/graphs/momentumGraph.dart';
import 'package:vball_stats/widgets/WidgetFactory.dart';
import 'package:vball_stats/globals.dart' as globals;




enum NewGameState{
  INIT,
  ONGOING,
  PASSING,
  MOMENTUM_GRAPH,
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
  List<dynamic> gameSets;
  String selectedSet = '1';
  bool startupState = true;

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
      case NewGameState.MOMENTUM_GRAPH:
        return _momentumGraphPage();
      default:
        return _newGameCreation();
    }
 
  }


  Widget _momentumGraphPage(){
    return new ListView(
      shrinkWrap: true,
    children: <Widget>
      [new SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: new Column(
          children: [ MomentumGraph(),
          ]))]);
  }


  Widget _switchToMomentumGraphButton(){
    return new RaisedButton(
      child: new Text("Switch to Graph"),
      onPressed: () {setState(() {
        pageState = NewGameState.MOMENTUM_GRAPH;
      });},
    );
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


  Widget _gameInformation(){
    return new Row(
      children: [ 
        _vsText(),
        _timeStamp(),
        _setSelectionDropdown(),
        ]);
  }

  Widget _vsText(){
    return  new Padding(
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
        child: new Column(children: <Widget>[
          new Text(currentGame.userTeam),
          new Text("vs."),
          new Text(currentGame.opposingTeam)
        ],));
  }

  Widget _timeStamp(){
    return new Padding(
      padding: EdgeInsets.fromLTRB(20.0,20.0, 20.0, 5.0),
      child: new Column(
      children: <Widget>[
        new Text(currentGame.gameDate.day.toString()),
        new Text(currentGame.monthToString()),
        new Text(currentGame.gameDate.year.toString()),
      ],
    ));
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

  Widget _showSwitchToPassButton() {
    return new Padding(
      padding: EdgeInsets.fromLTRB(0.0, 0.0, 15.0, 0.0),
      child: new RaisedButton(
        child: new Text("Switch to passing"),
        onPressed: (){pageState = NewGameState.PASSING; setState(() {});},
      ),
    );
  }

  Widget _showSwitchToMainStatsButton() {
    return new Padding(
      padding: EdgeInsets.fromLTRB(0.0, 0.0, 15.0, 0.0),
      child: new RaisedButton(
        child: new Text("Switch to main stats"),
        onPressed: (){pageState = NewGameState.ONGOING; setState(() {});},
      ),
    );
  }

  void _validateAndSave() {
    final _form = _formKey.currentState;
    if(_form.validate()){
      _form.save();
      Roster roster = globals.currentTeam.roster;
      currentGame = new Game(userTeam: globals.currentTeam.teamName,
      opposingTeam: _opposingTeamName, 
      gameDate: DateTime.now(),
      userTeamStatlines: new StatLines.buildFromRoster(roster));
      //currentGame.players.sort((a,b) => int.parse(a.playerNumber).compareTo(int.parse(b.playerNumber)));
      // globals.currentTeam.gamesList.add(currentGame);
      setState(() {pageState = NewGameState.ONGOING;});
    }
  }



  void _leaveUnsavedConfirmPopup() {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context){
        return new AlertDialog(
    content:new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Text("Game data will not be saved, do you wish to continue",textAlign: TextAlign.center,),
                new RaisedButton(
                  onPressed: () {Navigator.pop(context); setState(() {
                   pageState = NewGameState.INIT; 
                  });},
                  child: new Text("Yes"),),
          
              new RaisedButton(onPressed:() => Navigator.pop(context),
              child: new Text("No"),)
            ],
          ),
      ),);});
  }

  Widget _statsPage() {
    return new GestureDetector(
      onTap: () => setState((){}),
    child: new WillPopScope(
      onWillPop: (){_leaveUnsavedConfirmPopup();},
    child: new SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child:
    new Column(crossAxisAlignment: CrossAxisAlignment.start, children: [ 
      _gameInformation(),   
    _showSelectedSetForMainStats(),
    new Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
      child: new RaisedButton(
        child: new Text("End Game"),
        onPressed: () {pageState = NewGameState.ENDED; setState(() {});},
      ),),
      _showSwitchToPassButton(),]))));
  }

  Widget _showSelectedSetForMainStats() {
    // return WidgetFactory.createMutableStatsTable(currentGame.userTeamStatlines, ()=>setState((){}));
    if (selectedSet == "all") {
      return WidgetFactory.createImmutableStatsTable(currentGame.getStatLinesForWholeGame(globals.currentTeam.roster));
    }
    else {
      switch (selectedSet) {
        case "1":
          return WidgetFactory.createMutableStatsTable(currentGame.set1.statLines, ()=>setState((){}));
        case "2":
          return WidgetFactory.createMutableStatsTable(currentGame.set2.statLines, ()=>setState((){}));
        case "3":
          return WidgetFactory.createMutableStatsTable(currentGame.set3.statLines, ()=>setState((){}));
        case "4":
          return WidgetFactory.createMutableStatsTable(currentGame.set4.statLines, ()=>setState((){}));
        case "5":
          return WidgetFactory.createMutableStatsTable(currentGame.set5.statLines, ()=>setState((){}));
        default:
          return new Text("AN ERROR HAS OCCURRED");
      }
    }
  }

  Widget _setSelectionDropdown() {
    gameSets = [
      currentGame.set1,
      currentGame.set2,
      currentGame.set3,
      currentGame.set4,
      currentGame.set5,
      new Set('all'),
    ];
    if (startupState == true) {
      for (Set s in gameSets) {
        s.statLines = StatLines.buildFromRoster(globals.currentTeam.roster);
      }
    }
    startupState = false;
    return DropdownButton<dynamic>(
      value: selectedSet,
      onChanged: (newValue) {
        setState(() {
         selectedSet = newValue; 
        });
      },
      items: gameSets
        .map<DropdownMenuItem<dynamic>>((currentSet) {
          return DropdownMenuItem<dynamic>(
            value: currentSet.setNumber,
            child: new Text(currentSet.setNumber),
          );
        }).toList(),
    );
  }

  Widget _endGamePrompt() {
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


  Widget _passingPage() {
    return new WillPopScope(
      onWillPop: (){_leaveUnsavedConfirmPopup();},
    child: new SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: 
      new Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _gameInformation(),
        _showSelectedSetForPassingStats(),
        new Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: new RaisedButton(
        child: new Text("End Game"),
        onPressed: () {pageState = NewGameState.ENDED; setState(() {});},
      ),),
      _showSwitchToMainStatsButton(),
      ],),
    ));
  }  

  Widget _showSelectedSetForPassingStats() {
    // return WidgetFactory.createMutableStatsTable(currentGame.userTeamStatlines, ()=>setState((){}));
    if (selectedSet == "all") {
      return WidgetFactory.createImmutablePassingTable(currentGame.getStatLinesForWholeGame(globals.currentTeam.roster));
    }
    else {
      switch (selectedSet) {
        case "1":
          return WidgetFactory.createMutablePassingTable(currentGame.set1.statLines, ()=>setState((){}));
        case "2":
          return WidgetFactory.createMutablePassingTable(currentGame.set2.statLines, ()=>setState((){}));
        case "3":
          return WidgetFactory.createMutablePassingTable(currentGame.set3.statLines, ()=>setState((){}));
        case "4":
          return WidgetFactory.createMutablePassingTable(currentGame.set4.statLines, ()=>setState((){}));
        case "5":
          return WidgetFactory.createMutablePassingTable(currentGame.set5.statLines, ()=>setState((){}));
        default:
          return new Text("AN ERROR HAS OCCURRED");
      }
    }
  }

  void endGame() {
    globals.currentTeam.gamesList.add(currentGame);
    Firestore.instance.collection("Teams").document(globals.currentTeam.teamID).updateData(globals.currentTeam.toJson());
    setState(() {
     pageState = NewGameState.INIT; 
    });
  }
}