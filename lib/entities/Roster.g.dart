// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Roster.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Roster _$RosterFromJson(Map json) {
  return Roster()
    ..playerList = (json['playerList'] as List)
        ?.map((e) => e == null
            ? null
            : Player.fromJson((e as Map)?.map(
                (k, e) => MapEntry(k as String, e),
              )))
        ?.toList();
}

Map<String, dynamic> _$RosterToJson(Roster instance) => <String, dynamic>{
      'playerList': instance.playerList?.map((e) => e?.toJson())?.toList(),
    };
