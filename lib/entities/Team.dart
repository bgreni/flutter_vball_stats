import 'package:flutter/foundation.dart';

import 'Coach.dart';
import 'User.dart';
import 'Player.dart';
import 'Game.dart';
import 'StatLine.dart';
import 'StatLines.dart';
import 'Roster.dart';
import 'package:json_annotation/json_annotation.dart';
part 'Team.g.dart';

@JsonSerializable(explicitToJson: true)

class Team {
  String teamName;
  User headCoach;
  Roster roster;
  List<Coach> assistantCoachList;
  String teamID;
  List<Game> gamesList;
  String joinCode;

  Team({this.teamName, this.headCoach, this.teamID}) {
    this.roster = new Roster();
    this.assistantCoachList = new List();
    this.gamesList = new List();
  }

  void addPlayer(Player newPlayer) {
    this.roster.playerList.add(newPlayer);
  }
  void addAssistanceCoach(Coach assistantCoach) {
    this.assistantCoachList.add(assistantCoach);
  }

  StatLines getPlayerTotals() {
    StatLines totalsStatLine = new StatLines.buildFromRoster(this.roster);
    for (Game game in gamesList) {
      StatLines gameStatLines = game.getStatLinesForWholeGame();
      for (StatLine statLine in gameStatLines.statLineList) {
        StatLine matchingStatLine = totalsStatLine.statLineList.where((stl)
          => stl.player.name == statLine.player.name).first;
          matchingStatLine.mergeStatLines(statLine);
      }
    }
    return totalsStatLine;
  }

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);
  Map<String, dynamic> toJson() => _$TeamToJson(this);
  
  // Team fromJson(Map<String, dynamic> json) {
  //   Team team = Team(
  //       teamName: json['teamName'] as String,
  //       headCoach: json['headCoach'] == null
  //           ? null
  //           : User().fromJson(Map<String, dynamic>.from(json['headCoach'])
  //               as Map<String, dynamic>))
  //               ..joinCode = json['joinCode'];
  //   team.roster = Roster().fromJson(json['roster']);

  //   var list2 = json['assistantCoachList'];
  //   list2.forEach((coach) => team.addAssistanceCoach(
  //       Coach().fromJson(Map<String, dynamic>.from(coach))));
  //   team.teamID = json['teamID'] as String;

  //   var list3 = json['gamesList'];
  //   list3.forEach((game) =>
  //       team.gamesList.add(Game().fromJson(Map<String, dynamic>.from(game))));

  //   return team;
  // }

  // Map<String, dynamic> toJson() => <String, dynamic>{
  //       'teamName': this.teamName,
  //       'headCoach': this.headCoach.toJson(),
  //       'roster': this.roster.toJson(),
  //       'assistantCoachList': Coach().listToJson(this.assistantCoachList),
  //       'gamesList': Game().listToJson(this.gamesList),
  //       'teamID': this.teamID,
  //       'joinCode': this.joinCode,
  //     };
}
