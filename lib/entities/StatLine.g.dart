// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'StatLine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatLine _$StatLineFromJson(Map json) {
  return StatLine(
    player: json['player'] == null
        ? null
        : Player.fromJson((json['player'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
  )
    ..kills = json['kills'] as double
    ..continues = json['continues'] as double
    ..blocks = json['blocks'] as double
    ..errors = json['errors'] as double
    ..blocked = json['blocked'] as double
    ..digs = json['digs'] as double
    ..aces = json['aces'] as double
    ..serveErrors = json['serveErrors'] as double
    ..threes = json['threes'] as double
    ..twos = json['twos'] as double
    ..ones = json['ones'] as double
    ..zeros = json['zeros'] as double;
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
      'zeros': instance.zeros,
    };
