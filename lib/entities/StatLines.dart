import 'StatLine.dart';
import 'Roster.dart';
import 'package:json_annotation/json_annotation.dart';
part 'StatLines.g.dart';

@JsonSerializable(explicitToJson: true)

class StatLines {
  List<StatLine> statLineList;

  StatLines() {
    this.statLineList = new List();
  }

  factory StatLines.buildFromRoster(Roster roster) {
    StatLines newStatLines = new StatLines();
    roster.playerList.forEach((player) =>
      newStatLines.statLineList.add(new StatLine(player: player)));
    return newStatLines;
  }

  factory StatLines.fromJson(Map<String, dynamic> json) => _$StatLinesFromJson(json);
  Map<String, dynamic> toJson() => _$StatLinesToJson(this);

  // StatLines fromJson(List<dynamic> json) {
  //   StatLines newStatLines = new StatLines();
  //   var list = json;
  //   list.forEach((statLine) =>
  //     newStatLines.statLineList.add(StatLine().fromJson(statLine.cast<String,dynamic>())));

  //   return newStatLines;
  // }

  // List<Map<String, dynamic>> toJson() {
  //   var jsonList = new List<Map<String, dynamic>>();
  //   statLineList.forEach((statLine) => 
  //     jsonList.add(statLine.toJson()));

  //   return jsonList;
  // }
}