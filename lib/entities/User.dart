
import 'package:json_annotation/json_annotation.dart';
part 'User.g.dart';

@JsonSerializable(explicitToJson: true)

class User{
  String userID;
  String username;
  String email;
  bool isCoach;
  List<String> myTeams;

  User({this.userID,this.email,this.isCoach,this.username}){
    if(myTeams == null){
      myTeams = new List();
    }
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);


  // User fromJson(Map<String,dynamic> json){
  //   return User(
  //     userID: json['userID'] as String,
  //     username: json['username'] as String,
  //     email: json['email'] as String,
  //     isCoach: json['isCoach'] as bool)
  //     ..myTeams = List<String>.from(json['myTeams']);
  // }

  // Map<String,dynamic> toJson() => <String,dynamic>{
  //   'userID': this.userID,
  //   'username': this.username,
  //   'email': this.email,
  //   'isCoach': this.isCoach,
  //   'myTeams': this.myTeams,
  // };
}