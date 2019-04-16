
import 'package:json_annotation/json_annotation.dart';

part 'Coach.g.dart';

@JsonSerializable()
class Coach {

  String name;
  String coachID;
  bool isCoach;

  Coach({this.name,this.coachID}){
    isCoach = true;
  }



  Map<String,dynamic> listToJson(List<Coach> coachList){
    final m = new Map<String,dynamic>();
    coachList.forEach((coach) => {m[coach.name] = coach.toJson()});
    return m;
  }

  factory Coach.fromJson(Map<String,dynamic> json) => _$CoachFromJson(json);

  Map<String,dynamic> toJson() => _$CoachToJson(this);
  
}