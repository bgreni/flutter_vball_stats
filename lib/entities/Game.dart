import 'Team.dart';
import 'Set.dart';
import 'Player.dart';
import 'StatLines.dart';
import 'StatLine.dart';
import 'package:json_annotation/json_annotation.dart';
part 'Game.g.dart';

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
  StatLines userTeamStatlines;

  Game({this.userTeam, this.opposingTeam, this.userTeamStatlines, this.gameDate}){
    userTeamStatlines == null ? userTeamStatlines = new StatLines() : null;
    this.set1 = new Set('1');
    this.set2 = new Set('2');
    this.set3 = new Set('3');
    this.set4 = new Set('4');
    this.set5 = new Set('5');
  }

  //StatLine gameStatLineByPlayer(String playerName) {

  //}

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

  StatLines getStatLinesForWholeGame() {
    List<Set> setList = [set2, set3, set4, set5];
    StatLines totals = set1.statLines;
    for (Set setX in setList) {
      for (StatLine statLine in totals.statLineList) {
        StatLine matchingStatLine = setX.statLines.statLineList.where((stl)
          => stl.player.name == statLine.player.name).first;
          statLine.mergeStatLines(matchingStatLine);
      }
    }
    return totals;
  }

  List<Map<String, dynamic>> listToJson(List<Game> games) {
    var gamesList = List<Map<String, dynamic>>();
    games.forEach((game) => gamesList.add(game.toJson()));
    return gamesList;
  }

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
  Map<String, dynamic> toJson() => _$GameToJson(this);

  // Game fromJson(Map<String, dynamic> json) {
  //   Game game = Game(
  //     userTeam: json['userTeam'] as String,
  //     opposingTeam: json['opposingTeam'] as String,
  //     gameDate: json['gameDate'] as DateTime,
  //   );

  //   game.set1 = Set('1').fromJson(json['set1'].cast<String, dynamic>());
  //   game.set2 = Set('2').fromJson(json['set2'].cast<String, dynamic>());
  //   game.set3 = Set('3').fromJson(json['set3'].cast<String, dynamic>());
  //   game.set4 = Set('4').fromJson(json['set4'].cast<String, dynamic>());
  //   game.set5 = Set('5').fromJson(json['set5'].cast<String, dynamic>());
  //   userTeamStatlines = StatLines().fromJson(json['players']);

  //  return game;
  // }

  // Map<String, dynamic> toJson() => <String, dynamic>{
  //       'userTeam': this.userTeam,
  //       'opposingTeam': this.opposingTeam,
  //       'gameDate': this.gameDate,
  //       'set1': this.set1.toJson(),
  //       'set2': this.set2.toJson(),
  //       'set3': this.set3.toJson(),
  //       'set4': this.set4.toJson(),
  //       'set5': this.set5.toJson(), 
  //       'players': userTeamStatlines.toJson(),
  //     };
}

