// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'StatLine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatLine _$StatLineFromJson(Map<String, dynamic> json) {
  return StatLine(
      player: json['player'] == null
          ? null
          : Player.fromJson(json['player'] as Map<String, dynamic>))
    ..kills = json['kills'] as int
    ..continues = json['continues'] as int
    ..blocks = json['blocks'] as int
    ..errors = json['errors'] as int
    ..blocked = json['blocked'] as int
    ..digs = json['digs'] as int
    ..aces = json['aces'] as int
    ..serveErrors = json['serveErrors'] as int
    ..threes = json['threes'] as int
    ..twos = json['twos'] as int
    ..ones = json['ones'] as int
    ..zeros = json['zeros'] as int;
}

Map<String, dynamic> _$StatLineToJson(StatLine instance) => <String, dynamic>{
      'player': instance.player?.toJson(),
      'kills': instance.kills,
      'continues': instance.continues,
      'blocks': instance.blocks,
      'errors': instance.errors,
      'blocked': instance.blocked,
      'digs': instance.digs,
      'aces': instance.aces,
      'serveErrors': instance.serveErrors,
      'threes': instance.threes,
      'twos': instance.twos,
      'ones': instance.ones,
      'zeros': instance.zeros
    };
