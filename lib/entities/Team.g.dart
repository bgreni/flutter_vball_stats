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
          : Coach.fromJson(json['headCoach'] as Map<String, dynamic>))
    ..playerList = (json['playerList'] as List)
        ?.map((e) =>
            e == null ? null : Player.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..assistantCoachList = (json['assistantCoachList'] as List)
        ?.map(
            (e) => e == null ? null : Coach.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..teamID = json['teamID'] as String;
}

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
      'teamName': instance.teamName,
      'headCoach': instance.headCoach.toJson(),
      'playerList': Player().listToJson(instance.playerList),
      'assistantCoachList': Coach().listToJson(instance.assistantCoachList),
      'teamID': instance.teamID
    };