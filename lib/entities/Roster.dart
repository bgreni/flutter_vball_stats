import 'Player.dart';
import 'package:json_annotation/json_annotation.dart';
part 'Roster.g.dart';

@JsonSerializable(explicitToJson: true)

class Roster {
  List<Player> playerList;

  Roster() {
    this.playerList = new List();
  }

  factory Roster.fromJson(Map<String, dynamic> json) => _$RosterFromJson(json);
  Map<String, dynamic> toJson() => _$RosterToJson(this);

  // Roster fromJson(var json) {
  //   Roster newRoster = new Roster();
  //   var list = json;
  //   list.forEach((player) =>
  //   newRoster.playerList.add(Player().fromJson(Map<String, dynamic>.from(player))));

  //   return newRoster;
  // }

  // List<Map<String, dynamic>> toJson() {
  //   var jsonList = new List<Map<String, dynamic>>();
  //   this.playerList.forEach((player) =>
  //     jsonList.add(player.toJson()));

  //   return jsonList;
  // }
}