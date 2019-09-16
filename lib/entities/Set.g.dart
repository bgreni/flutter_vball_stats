// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Set _$SetFromJson(Map json) {
  return Set(
    json['setNumber'] as String,
  )
    ..userTeamScore = json['userTeamScore'] as int
    ..opposingTeamScore = json['opposingTeamScore'] as int
    ..statLines = json['statLines'] == null
        ? null
        : StatLines.fromJson((json['statLines'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          ));
}

Map<String, dynamic> _$SetToJson(Set instance) => <String, dynamic>{
      'userTeamScore': instance.userTeamScore,
      'opposingTeamScore': instance.opposingTeamScore,
      'statLines': instance.statLines?.toJson(),
      'setNumber': instance.setNumber,
    };
