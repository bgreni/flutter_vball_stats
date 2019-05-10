
import 'package:json_annotation/json_annotation.dart';
import 'Coach.dart';
import 'Player.dart';
import 'dart:convert';


@JsonSerializable()

class Team {

  String teamName;
  Coach headCoach;
  List<Player> playerList;
  List<Coach> assistantCoachList;
  String teamID;

  Team({this.teamName,this.headCoach,this.teamID}){
    this.playerList = new List();
    this.assistantCoachList = new List();
  }

  void addPlayer(Player newPlayer){
    this.playerList.add(newPlayer);
  }

  void addAssistanceCoach(Coach assistantCoach){
    this.assistantCoachList.add(assistantCoach);
  }

  



  Team fromJson(Map<String, dynamic> json) {
  Team team = Team(
      teamName: json['teamName'] as String,
      headCoach: json['headCoach'] == null
          ? null
          : Coach().fromJson(Map<String,dynamic>.from(json['headCoach']) as Map<String, dynamic>));
    List<dynamic> list = json['playerList'];
    list.forEach((player) => team.addPlayer(Player().fromJson(Map<String,dynamic>.from(player))));
    
    List<dynamic> list2 = json['assistantCoachList'];
    list.forEach((coach) => team.addAssistanceCoach(Coach().fromJson(Map<String,dynamic>.from(coach))));
    team.teamID = json['teamID'] as String;
    return team;
}

Map<String, dynamic> toJson() => <String, dynamic>{
      'teamName': this.teamName,
      'headCoach': this.headCoach.toJson(),
      'playerList': Player().listToJson(this.playerList),
      'assistantCoachList': Coach().listToJson(this.assistantCoachList),
      'teamID': this.teamID
    };

}


