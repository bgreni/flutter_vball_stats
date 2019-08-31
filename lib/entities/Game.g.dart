// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Game _$GameFromJson(Map<String, dynamic> json) {
  return Game(
      userTeam: json['userTeam'] as String,
      opposingTeam: json['opposingTeam'] as String,
      userTeamStatlines: json['userTeamStatlines'] == null
          ? null
          : StatLines.fromJson(
              json['userTeamStatlines'] as Map<String, dynamic>),
      gameDate: json['gameDate'] == null
          ? null
          : DateTime.parse(json['gameDate'] as String))
    ..set1 = json['set1']
    ..set2 = json['set2']
    ..set3 = json['set3']
    ..set4 = json['set4']
    ..set5 = json['set5'];
}

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      'userTeam': instance.userTeam,
      'opposingTeam': instance.opposingTeam,
      'gameDate': instance.gameDate?.toIso8601String(),
      'set1': instance.set1,
      'set2': instance.set2,
      'set3': instance.set3,
      'set4': instance.set4,
      'set5': instance.set5,
      'userTeamStatlines': instance.userTeamStatlines?.toJson()
    };
