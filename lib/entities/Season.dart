import 'Team.dart';
import 'package:json_annotation/json_annotation.dart';
part 'Season.g.dart';

@JsonSerializable(explicitToJson: true)

class Season {
  Team team;
  String year; 

  Season({this.team, this.year});

  factory Season.fromJson(Map<String, dynamic> json) => _$SeasonFromJson(json);
  Map<String, dynamic> toJson() => _$SeasonToJson(this);

  // Season fromJson(Map<String, dynamic> json) {
  //   return Season(
  //     team: Team().fromJson(json['team']) as Team,
  //     year: json['year'] as String);
  // }

  // Map<String, dynamic> toJson() => <String, dynamic> {
  //   'team': team.toJson(),
  //   'year': year,
  // };

}