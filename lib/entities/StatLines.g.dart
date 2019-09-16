// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'StatLines.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatLines _$StatLinesFromJson(Map json) {
  return StatLines()
    ..statLineList = (json['statLineList'] as List)
        ?.map((e) => e == null
            ? null
            : StatLine.fromJson((e as Map)?.map(
                (k, e) => MapEntry(k as String, e),
              )))
        ?.toList();
}

Map<String, dynamic> _$StatLinesToJson(StatLines instance) => <String, dynamic>{
      'statLineList': instance.statLineList?.map((e) => e?.toJson())?.toList(),
    };
