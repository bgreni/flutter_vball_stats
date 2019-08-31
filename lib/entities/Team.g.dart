// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Team _$TeamFromJson(Map<String, dynamic> json) {
  return Team(
      teamName: json['teamName'] as String,
      headCoach: json['headCoach'] == null
          ? null
          : User.fromJson(json['headCoach'] as Map<String, dynamic>),
      teamID: json['teamID'] as String)
    ..roster = json['roster'] == null
        ? null
        : Roster.fromJson(json['roster'] as Map<String, dynamic>)
    ..assistantCoachList = (json['assistantCoachList'] as List)
        ?.map(
            (e) => e == null ? null : Coach.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..gamesList = (json['gamesList'] as List)
        ?.map(
            (e) => e == null ? null : Game.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..joinCode = json['joinCode'] as String;
}

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
      'teamName': instance.teamName,
      'headCoach': instance.headCoach?.toJson(),
      'roster': instance.roster?.toJson(),
      'assistantCoachList':
          instance.assistantCoachList?.map((e) => e?.toJson())?.toList(),
      'teamID': instance.teamID,
      'gamesList': instance.gamesList?.map((e) => e?.toJson())?.toList(),
      'joinCode': instance.joinCode
    };
