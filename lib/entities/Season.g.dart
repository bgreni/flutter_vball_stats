// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Season.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Season _$SeasonFromJson(Map json) {
  return Season(
    team: json['team'] == null
        ? null
        : Team.fromJson((json['team'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
    year: json['year'] as String,
  );
}

Map<String, dynamic> _$SeasonToJson(Season instance) => <String, dynamic>{
      'team': instance.team?.toJson(),
      'year': instance.year,
    };
