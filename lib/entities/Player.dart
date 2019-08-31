
import 'package:json_annotation/json_annotation.dart';
part 'Player.g.dart';

@JsonSerializable(explicitToJson: true)

class Player {
  String name;
  String playerNumber;
  String playerPosition;

  Player({this.name, this.playerNumber, this.playerPosition});

  List<Map<String, dynamic>> listToJson(List<Player> playerList) {
    var m = new List<Map<String, dynamic>>();
    playerList.forEach((player) => m.add(player.toJson()));
    return m;
  }

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerToJson(this);

  // Player fromJson(Map<String, dynamic> json) {
  //   return Player(
  //       name: json['name'] as String,
  //       playerNumber: json['playerNumber'] as String,
  //       playerPosition: json['playerPosition'] as String);
  // }

  // Map<String, dynamic> toJson() => <String, dynamic>{
  //       'name': this.name,
  //       'playerNumber': this.playerNumber,
  //       'playerPosition': this.playerPosition,
  //     };
}
