import 'package:flutter/material.dart';
import 'package:vball_stats/pages/MyAppBar.dart';
import 'PlayerStatsPage.dart';
import 'NewGamePage.dart';
import 'AllGamesPage.dart';
import 'package:vball_stats/entities/Team.dart';
import 'package:vball_stats/globals.dart' as globals;
import 'JoinCodePage.dart';

/// Root page for all team related activities
/// shown after the users chooses a team

class TeamRoot extends StatefulWidget {
  // TODO: check if this is even needed
  final auth;
  // will likely be needed later
  final String userId;

  TeamRoot({this.auth, this.userId}){
  }

  @override
  State<StatefulWidget> createState() => _TeamRootState();
}

// state values of the root
enum PageState {
  PLAYER_STATS,
  NEW_GAME,
  ALL_GAMES,
  SET_JOIN_CODE
}

class _TeamRootState extends State<TeamRoot> {
  // default state is player stats because I said so
  PageState pageState = PageState.PLAYER_STATS;
  // app bar text
  String _barText;

  @override
  void initState() {
    super.initState();
    _barText = "Player Stats";
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: MyAppBar(appBarContext: context,barText: _barText,),
        body: chooseBody(),
        drawer: myDrawer());
  }

  Widget chooseBody(){
    // switch statement to choose with page body we need
    switch(pageState){
      case PageState.PLAYER_STATS:
        return PlayerStatsPage();
      case PageState.NEW_GAME:
        return NewGamePage();
      case PageState.ALL_GAMES:
        return AllGamesPage();
      case PageState.SET_JOIN_CODE:
        return JoinCodePage();
      default:
      return PlayerStatsPage();
    }
  }

  Widget myDrawer() {
    // creates the side drawer that contains the pages for the user to choose from
    return new Drawer(
      child: new ListView(
        children: <Widget>[
          new DrawerHeader(child: new Text("Team Options")),
          new ListTile(
            title: new Text("View Player Stats"),
            onTap: () {
              goToPlayerStats();
              Navigator.pop(context);
            },
          ),
          new ListTile(
            title: new Text("New Game"),
            onTap: (){
              goToNewGame();
              Navigator.pop(context);
            },
          ),
          new ListTile(
            title: new Text("View All Games"),
            onTap: (){
              goToAllGames();
              Navigator.pop(context);
            },
          ),
          new ListTile(
            title: new Text("Set Join Code"),
            onTap: (){
            goToJoinCodePage();
            Navigator.pop(context);
            })
        ],
      ),
    );
  }

  void goToJoinCodePage(){
    setState(() {
     pageState = PageState.SET_JOIN_CODE;
     _barText = "Set Join Code"; 
    });
  }

  void goToAllGames(){
    setState(() {
     pageState = PageState.ALL_GAMES;
     _barText = "Games"; 
    });
  }

  void goToNewGame(){
    setState(() {
     pageState = PageState.NEW_GAME; 
     _barText = "New Game";
    });
  }

  void goToPlayerStats() {
    setState(() {
      pageState = PageState.PLAYER_STATS;
      _barText = "Player Stats";
    });
  }

}
