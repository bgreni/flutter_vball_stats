// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map json) {
  return User(
    userID: json['userID'] as String,
    email: json['email'] as String,
    isCoach: json['isCoach'] as bool,
    username: json['username'] as String,
  )..myTeams = (json['myTeams'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userID': instance.userID,
      'username': instance.username,
      'email': instance.email,
      'isCoach': instance.isCoach,
      'myTeams': instance.myTeams,
    };
