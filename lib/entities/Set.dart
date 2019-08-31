import 'StatLines.dart';
import 'StatLine.dart';
import 'package:json_annotation/json_annotation.dart';
part 'Set.g.dart';

@JsonSerializable(explicitToJson: true)

class Set {

  int userTeamScore;
  int opposingTeamScore;
  StatLines statLines;
  String setNumber;

  Set(String setNumber) {
    this.userTeamScore = 0;
    this.opposingTeamScore = 0;
    this.statLines = new StatLines();
    this.setNumber = setNumber;
  }

  StatLine getStatLineByPLayer(String indexPlayer) {
    return statLines.statLineList
      .firstWhere((statLine) =>
      statLine.player
        .name == indexPlayer);
  }

  factory Set.fromJson(Map<String, dynamic> json) => _$SetFromJson(json);
  Map<String, dynamic> toJson() => _$SetToJson(this);

  // Set fromJson(Map<String, dynamic> json) {
  //   return Set(json['setNumber'])
  //   ..userTeamScore = json['userTeamScore']
  //   ..opposingTeamScore = json['opposingTeamScore']
  //   ..statLines = StatLines().fromJson(json['statLines']);
  // }

  // Map<String, dynamic> toJson() => <String, dynamic> {
  //   'userTeamScore': this.userTeamScore,
  //   'opposingTeamScore': this.opposingTeamScore,
  //   'statLines': this.statLines.toJson(),
  //   'setNumber': this.setNumber,
  // };

}