import 'Team.dart';
import 'Player.dart';

class Game {
  String userTeam;
  String opposingTeam;
  DateTime gameDate;
  List<ScorePair> scores;
  List<Player> players;

  Game({this.userTeam,this.opposingTeam,this.players,this.gameDate}){
    this.scores = new List();
  }

  List<Map<String,dynamic>> listToJson(List<Game> games){
    var gamesList = List<Map<String,dynamic>>();
    games.forEach((game) => gamesList.add(game.toJson()));
    return gamesList;
  }

  Game fromJson(Map<String, dynamic> json){
    Game game = Game(
      userTeam: json['userTeam'] as String,
      opposingTeam: json['opposingTeam'] as String,
      gameDate: json['gameDate'] as DateTime,
    );
    List<dynamic> list = json['scoreList'];
    list.forEach((score) => game.scores.add(ScorePair().fromJson(score)));

    List<dynamic> playerList = json['players'];
    playerList.forEach((player) => game.players.add(Player().fromJson(player)));
  }



  Map<String,dynamic> toJson() => <String,dynamic>{
    'userTeam': this.userTeam,
    'opposingTeam': this.opposingTeam,
    'gameDate': this.gameDate,
    'scores': ScorePair().listToJson(this.scores),
    'players': Player().listToJson(this.players),
  };
}


class ScorePair{
  int userTeamScore;
  int opposingScore;

  ScorePair({this.userTeamScore,this.opposingScore});

  String toString(){
    return '$userTeamScore : $opposingScore';
  }

  ScorePair fromJson(Map<String,dynamic> json){
    return ScorePair(
      userTeamScore: json['userTeamScore'] as int,
      opposingScore: json['opposingTeamScore'] as int,
    );
  }


  Map<String,dynamic> toJson() => <String,dynamic>{
    'userTeamScore': this.userTeamScore,
    'opposingTeamScore': this.opposingScore,
  };

  List<Map<String,dynamic>> listToJson(List<ScorePair> scoreList){
    var list = new List<Map<String,dynamic>>();
    scoreList.forEach((score) => list.add(score.toJson()));
    return list;
  }
}