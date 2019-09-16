
import 'Set.dart';
import 'StatLines.dart';
import 'StatLine.dart';
import 'Roster.dart';
import 'package:json_annotation/json_annotation.dart';
part 'Game.g.dart';

/// Implementation of the Game object
/// Stores all information relevant to a single game
/// 
/// Members:
///   String userTeam: the name of the userTeam 
///   String opposingTeam: the name of the team the user played in this game
///   Set set1/2/3/..: a set object for each set in the game

@JsonSerializable(explicitToJson: true)

class Game {
  String userTeam;
  String opposingTeam;
  DateTime gameDate;
  Set set1;
  Set set2;
  Set set3;
  Set set4;
  Set set5;

  // TODO does this need to be here anymore??
  StatLines userTeamStatlines;

  Game({this.userTeam, this.opposingTeam, this.userTeamStatlines, this.gameDate, this.set1, this.set2, this.set3, this.set4, this.set5}){
    userTeamStatlines == null ? userTeamStatlines = new StatLines() : null;
    this.set1 == null ? set1 = new Set('1') : null;
    this.set2 == null ? set2 = new Set('2') : null;
    this.set3 == null ? set3 = new Set('3') : null;
    this.set4 == null ? set4 = new Set('4') : null;
    this.set5 == null ? set5 = new Set('5') : null;
  }

  // TODO finish this implementation
  //StatLine gameStatLineByPlayer(String playerName) {

  //}

  /// returns a string for the month the game was played
  String monthToString(){
    switch(gameDate.month){
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
      default:
         return "Somethings Wrong";  
      }
  }

  /// get all players total StatLines for this game
  StatLines getStatLinesForWholeGame(Roster roster) {
    List<Set> setList = [set1, set2, set3, set4, set5];
    StatLines totals = StatLines.buildFromRoster(roster);
    for (Set setX in setList) {
      for (StatLine statLine in totals.statLineList) {
        StatLine matchingStatLine = setX.statLines.statLineList.where((stl)
          => stl.player.name == statLine.player.name).first;
          statLine.mergeStatLines(matchingStatLine);
      }
    }
    return totals;
  }


  // json conversion definitions
  List<Map<String, dynamic>> listToJson(List<Game> games) {
    var gamesList = List<Map<String, dynamic>>();
    games.forEach((game) => gamesList.add(game.toJson()));
    return gamesList;
  }

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
  Map<String, dynamic> toJson() => _$GameToJson(this);
}

