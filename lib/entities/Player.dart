import 'package:json_annotation/json_annotation.dart';

part 'Player.g.dart';

@JsonSerializable()
class Player {
  String name;
  String playerID;
  String playerPosition;
  bool isCoach;

  Player({this.name,this.playerID,this.playerPosition}){
    this.isCoach = false;  
  }


  Map<String,dynamic> listToJson(List<Player> playerList){
    final m = new Map<String,dynamic>();
    playerList.forEach((player) {m[player.name] = player.toJson(); });
    return m;
  } 

  factory Player.fromJson(Map<String,dynamic> json) => _$PlayerFromJson(json);

  Map<String,dynamic> toJson() => _$PlayerToJson(this);
  
}