// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Player _$PlayerFromJson(Map<String, dynamic> json) {
  return Player(
      name: json['name'] as String,
      playerID: json['playerID'] as String,
      playerPosition: json['playerPosition'] as String)
    ..isCoach = json['isCoach'] as bool;
}

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'name': instance.name,
      'playerID': instance.playerID,
      'playerPosition': instance.playerPosition,
      'isCoach': instance.isCoach
    };
