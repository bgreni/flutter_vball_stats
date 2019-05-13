
import 'Coach.dart';
import 'Player.dart';
import 'Game.dart';



class Team {

  String teamName;
  Coach headCoach;
  List<Player> playerList;
  List<Coach> assistantCoachList;
  String teamID;
  List<Game> gamesList;

  Team({this.teamName,this.headCoach,this.teamID}){
    this.playerList = new List();
    this.assistantCoachList = new List();
    this.gamesList = new List();
  }

  void addPlayer(Player newPlayer){
    this.playerList.add(newPlayer);
  }

  void addAssistanceCoach(Coach assistantCoach){
    this.assistantCoachList.add(assistantCoach);
  }

  List<Player> resetPlayerStats(){
    List<Player> temp = playerList;
    for(Player player in temp){
      player.kills = 0;
      player.continues = 0;
      player.blocks = 0;
      player.errors = 0;
      player.blocked = 0;
      player.digs = 0;
      player.aces = 0;
      player.serveErrors = 0;

      player.threes = 0;
      player.twos = 0;
      player.ones = 0;
      player.zeros = 0;
    }
    return temp;
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
    list2.forEach((coach) => team.addAssistanceCoach(Coach().fromJson(Map<String,dynamic>.from(coach))));
    team.teamID = json['teamID'] as String;

    List<dynamic> list3 = json['gamesList'];
    list3.forEach((game) => team.gamesList.add(Game().fromJson(game)));

    return team;
}

Map<String, dynamic> toJson() => <String, dynamic>{
      'teamName': this.teamName,
      'headCoach': this.headCoach.toJson(),
      'playerList': Player().listToJson(this.playerList),
      'assistantCoachList': Coach().listToJson(this.assistantCoachList),
      'gamesList': Game().listToJson(this.gamesList),
      'teamID': this.teamID
    };

}


