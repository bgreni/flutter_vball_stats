// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Game _$GameFromJson(Map json) {
  return Game(
    userTeam: json['userTeam'] as String,
    opposingTeam: json['opposingTeam'] as String,
    userTeamStatlines: json['userTeamStatlines'] == null
        ? null
        : StatLines.fromJson((json['userTeamStatlines'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
    gameDate: json['gameDate'] == null
        ? null
        : DateTime.parse(json['gameDate'] as String),
    set1: Set.fromJson(json['set1']),
    set2: Set.fromJson(json['set2']),
    set3: Set.fromJson(json['set3']),
    set4: Set.fromJson(json['set4']),
    set5: Set.fromJson(json['set5']),
  );
}

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      'userTeam': instance.userTeam,
      'opposingTeam': instance.opposingTeam,
      'gameDate': instance.gameDate?.toIso8601String(),
      'set1': instance.set1.toJson(),
      'set2': instance.set2.toJson(),
      'set3': instance.set3.toJson(),
      'set4': instance.set4.toJson(),
      'set5': instance.set5.toJson(),
      'userTeamStatlines': instance.userTeamStatlines?.toJson(),
    };
