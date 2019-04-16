
import 'package:json_annotation/json_annotation.dart';
import 'Coach.dart';
import 'Player.dart';
import 'dart:convert';


part 'Team.g.dart';

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

  factory Team.fromJson(Map<String,dynamic> json) => _$TeamFromJson(json);

  Map<String,dynamic> toJson() => _$TeamToJson(this);
}


