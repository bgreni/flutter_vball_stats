import 'package:flutter/material.dart';
import 'package:vball_stats/pages/MyAppBar.dart';
import 'PlayerStatsPage.dart';
import 'package:vball_stats/entities/Team.dart';
import 'package:vball_stats/globals.dart' as globals;

/// Root page for all team related activities
/// shown after the users chooses a team

class TeamRoot extends StatefulWidget {
  // TODO: check if this is even needed
  final auth;
  // will likely be needed later
  final String userId;
  // passed in from the team select page
  final Team team;

  TeamRoot({this.auth, this.userId, this.team}){
    globals.currentTeam = this.team;
  }

  @override
  State<StatefulWidget> createState() => _TeamRootState();
}

// state values of the root
enum PageState {
  PLAYER_STATS,
  NEW_GAME,
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
        // TODO: make this a real thing
        return _showNewGame();
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
            title: new Text("Other Page"),
            onTap: (){
              goToNewGame();
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
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



  Widget _showNewGame(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Text("HEY FUCKER"),
        new Text("KILL YOURSELF")
      ],);
  }
}
