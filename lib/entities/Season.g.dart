// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Season.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Season _$SeasonFromJson(Map<String, dynamic> json) {
  return Season(
      team: json['team'] == null
          ? null
          : Team.fromJson(json['team'] as Map<String, dynamic>),
      year: json['year'] as String);
}

Map<String, dynamic> _$SeasonToJson(Season instance) =>
    <String, dynamic>{'team': instance.team?.toJson(), 'year': instance.year};
