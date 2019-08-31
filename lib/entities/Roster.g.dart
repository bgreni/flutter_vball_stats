// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Roster.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Roster _$RosterFromJson(Map<String, dynamic> json) {
  return Roster()
    ..playerList = (json['playerList'] as List)
        ?.map((e) =>
            e == null ? null : Player.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$RosterToJson(Roster instance) => <String, dynamic>{
      'playerList': instance.playerList?.map((e) => e?.toJson())?.toList()
    };
