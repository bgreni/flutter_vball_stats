// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Coach.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coach _$CoachFromJson(Map json) {
  return Coach(
    name: json['name'] as String,
    coachID: json['coachID'] as String,
  )..isCoach = json['isCoach'] as bool;
}

Map<String, dynamic> _$CoachToJson(Coach instance) => <String, dynamic>{
      'name': instance.name,
      'coachID': instance.coachID,
      'isCoach': instance.isCoach,
    };
