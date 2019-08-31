// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Player _$PlayerFromJson(Map<String, dynamic> json) {
  return Player(
      name: json['name'] as String,
      playerNumber: json['playerNumber'] as String,
      playerPosition: json['playerPosition'] as String);
}

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'name': instance.name,
      'playerNumber': instance.playerNumber,
      'playerPosition': instance.playerPosition
    };
