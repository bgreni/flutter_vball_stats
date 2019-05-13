import 'package:json_annotation/json_annotation.dart';


@JsonSerializable()
class Player {
  String name;
  String playerNumber;
  String playerPosition;

  int kills;
  int continues;
  int blocks;
  int errors;
  int blocked;
  int digs;
  int aces;
  int serveErrors;

  int threes;
  int twos;
  int ones;
  int zeros;


  Player({this.name,this.playerNumber,this.playerPosition}){
    this.kills = 0;
    this.continues = 0;
    this.blocks = 0;
    this.errors = 0;
    this.blocked = 0;
    this.digs = 0;
    this.aces = 0;
    this.serveErrors = 0;
    this.threes = 0;
    this.twos = 0;
    this.ones = 0;
    this.zeros = 0;
  }


  List<Map<String,dynamic>> listToJson(List<Player> playerList){
    var m = new List<Map<String,dynamic>>();
    playerList.forEach((player) => m.add(player.toJson()));
    return m;
  } 

 Player fromJson(Map<String, dynamic> json) {
  return Player(
      name: json['name'] as String,
      playerNumber: json['playerNumber'] as String,
      playerPosition: json['playerPosition'] as String)
      ..kills = json['kills']
      ..continues = json['continues']
      ..blocks = json['blocks']
      ..errors = json['errors']
      ..blocked = json['blocked']
      ..digs = json['digs']
      ..aces = json['aces']
      ..serveErrors = json['serveErrors']
      ..threes = json['threes']
      ..twos = json['twos']
      ..ones = json['ones']
      ..zeros = json['zeros'];
}

Map<String, dynamic> toJson() => <String,dynamic>{
  'name': this.name,
  'playerNumber': this.playerNumber,
  'playerPosition': this.playerPosition,
  'kills': this.kills,
  'continues': this.continues,
  'blocks': this.blocks,
  'errors': this.errors,
  'blocked': this.blocked,
  'digs': this.digs,
  'aces': this.aces,
  'serveErrors': this.serveErrors,
  'threes': this.threes,
  'twos': this.twos,
  'ones': this.ones,
  'zeros': this.zeros,
  
};

  
}