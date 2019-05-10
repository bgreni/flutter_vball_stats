import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vball_stats/pages/CreateTeamPage.dart';
import 'package:vball_stats/pages/teamRoot.dart';
import 'package:vball_stats/pages/MyAppBar.dart';
import 'package:vball_stats/globals.dart' as globals;
import 'dart:convert';
import 'package:vball_stats/entities/Coach.dart';
import 'package:vball_stats/entities/Player.dart';
import 'package:vball_stats/entities/Team.dart';

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
    

        return new Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
        new ListView(
          // constrain the listview so it doesn't throw and error
          shrinkWrap: true,
          children: snapshot.data.documents.map((document){
            return new FractionallySizedBox(
              widthFactor: 0.5,
            child: new RaisedButton(
              child: new Text(document["teamName"]),
              onPressed: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => TeamRoot(team: Team().fromJson(document.data))));
              },
            )
            );
          }
          ).toList()
        
        
        ),        
        new RaisedButton(
          color: Colors.lightBlueAccent,
          child: new Text("Join a Team"),
          onPressed: (){
          Navigator.push(context, 
          MaterialPageRoute(builder: (context) => CreateTeamPage())
          );
          }
        )
        ]
        )
        );
      }
      );
  }

  Widget _showCoachTeamSelect(){
    return new StreamBuilder(
      stream: Firestore.instance.collection("Teams").snapshots(),
      builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){

        if (snapshot.data == null) return CircularProgressIndicator();
    

        return new Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
        new ListView(
          // constrain the listview so it doesn't throw and error
          shrinkWrap: true,
          children: snapshot.data.documents.map((document){
            return new FractionallySizedBox(
              widthFactor: 0.5,
            child: new RaisedButton(
              child: new Text(document["teamName"]),
              onPressed: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => TeamRoot(team: Team().fromJson(Map<String,dynamic>.from(document.data)))));
              },
            )
            );
          }
          ).toList()
        
        
        ),        
        new RaisedButton(
          color: Colors.lightBlueAccent,
          child: new Text("Create New Team"),
          onPressed: (){
          Navigator.push(context, 
          MaterialPageRoute(builder: (context) => CreateTeamPage())
          );
          }
        )
        ]
        )
        );
      }
      );
  }

  void checkForCoach() async{
    try{
    var userTemp = await Firestore.instance.collection("Users").document(widget.userID).get();
    globals.isCurrentUserCoach = userTemp["isCoach"];
    if(globals.isCurrentUserCoach){
      currentState = PageState.COACH;
      globals.coachUser = Coach().fromJson(userTemp.data);
      this.setState((){});
    }
    else{
      currentState = PageState.PLAYER;
      globals.playerUser = Player().fromJson(userTemp.data);
      this.setState((){});
    }
  }catch(e){

  }
  }

}
