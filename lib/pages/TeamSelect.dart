import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vball_stats/pages/CreateTeamPage.dart';
import 'package:vball_stats/pages/JoinTeamPage.dart';
import 'package:vball_stats/pages/teamRoot.dart';
import 'package:vball_stats/pages/MyAppBar.dart';
import 'package:vball_stats/globals.dart' as globals;
import 'package:vball_stats/entities/Team.dart';
import 'dart:convert';

class TeamSelect extends StatefulWidget{
  final String userID;


  TeamSelect({this.userID});

  @override
  State<StatefulWidget> createState() => _TeamSelectState();
}


enum PageState{ PLAYER, COACH, UNDECIDED}

class _TeamSelectState extends State<TeamSelect>{

  PageState currentState = PageState.UNDECIDED;
 
  @override
  Widget build(BuildContext context) {

    checkForCoach();
    return Scaffold(
      appBar: new MyAppBar(appBarContext: context,barText: "Select Team",),
      body: _showBody()
    );
  }

  Widget _showBody(){
    switch(currentState){
      case PageState.COACH:
        return _showCoachTeamSelect();
      case PageState.PLAYER:
        return _showPlayerSelect();
      case PageState.UNDECIDED:
        return Center( 
        child: new CircularProgressIndicator()
        );
      default:
        return null;
    }
  }


  Widget _showPlayerSelect(){
    return new StreamBuilder(
      stream: Firestore.instance.collection("Teams").snapshots(),
      builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){

        if (snapshot.data == null) return CircularProgressIndicator();
    

    bool hasTeams = false;
        for (var doc in snapshot.data.documents){
          if (globals.currentUser.myTeams.contains(doc['teamName'])){
            hasTeams = true;
            break;
          }
        }

        if (!hasTeams){
          return new Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Text("No Teams"),
                _joinTeamButton(),
              ],
            )
          );
        }   

        return new Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
        new ListView(
          // constrain the listview so it doesn't throw and error
          shrinkWrap: true,
          children: snapshot.data.documents.map((document){
            if(globals.currentUser.myTeams.contains(document["teamName"])){
            return new FractionallySizedBox(
              widthFactor: 0.5,
            child: new RaisedButton(
              child: new Text(document["teamName"]),
              onPressed: (){
                globals.currentTeam = Team.fromJson(document.data);
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => TeamRoot()));
              },
            )
            );
          }}
          ).toList()
        
        
        ),        
        _joinTeamButton(),
        ]
        )
        );
      }
      );
  }


  Widget _joinTeamButton(){
    return new RaisedButton(
          color: Colors.lightBlueAccent,
          child: new Text("Join a Team"),
          onPressed: (){
          Navigator.push(context, 
          MaterialPageRoute(builder: (context) => JoinTeamPage())
          );
          }
        );
  }

  Widget _showCoachTeamSelect(){
    return new StreamBuilder(
      stream: Firestore.instance.collection("Teams").snapshots(),
      builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){

        if (snapshot.data == null) return CircularProgressIndicator();

        bool hasTeams = false;
        for (var doc in snapshot.data.documents){
          if (globals.currentUser.myTeams.contains(doc['teamName'])){
            hasTeams = true;
            break;
          }
        }

        if (!hasTeams){
          return new Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Text("No Teams"),
                _createTeamButton(),
              ],
            )
          );
        }  

        return new Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
        new ListView(
          // constrain the listview so it doesn't throw and error
          shrinkWrap: true,
          children: snapshot.data.documents.map((document){
            if(globals.currentUser.myTeams.contains(document["teamName"])){
            return new FractionallySizedBox(
              widthFactor: 0.5,
            child: new RaisedButton(
              child: new Text(document["teamName"]),
              onPressed: (){
                globals.currentTeam = Team.fromJson(json.decode(json.encode(document.data)));
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => TeamRoot()));
              },
            )
            );
          }}
          ).toList()
        ),        
        _createTeamButton(),
        ]
        )
        );
      }
      );
  }

  Widget _createTeamButton(){
    return new RaisedButton(
          color: Colors.lightBlueAccent,
          child: new Text("Create New Team"),
          onPressed: (){
          Navigator.push(context, 
          MaterialPageRoute(builder: (context) => CreateTeamPage())
          );
          }
        );
  }

  void checkForCoach() async{
    try{
    if(globals.currentUser.isCoach){
      currentState = PageState.COACH;
      this.setState((){});
    }
    else{
      currentState = PageState.PLAYER;
      this.setState((){});
    }
  }catch(e){
    print(e);
  }
  }

}
