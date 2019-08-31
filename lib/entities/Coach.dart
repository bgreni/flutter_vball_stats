
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



  List<Map<String,dynamic>> listToJson(List<Coach> coachList){
    final m = new List<Map<String,dynamic>>();
    coachList.forEach((coach) => {m.add(coach.toJson())});
    return m;
  }

  factory Coach.fromJson(Map<String, dynamic> json) => _$CoachFromJson(json);
  Map<String, dynamic> toJson() => _$CoachToJson(this);

//   Coach fromJson(Map<String, dynamic> json) {
//   return Coach(name: json['name'] as String, coachID: json['coachID'] as String)
//     ..isCoach = json['isCoach'] as bool;
// }

// Map<String, dynamic> toJson() => <String, dynamic>{
//       'name': this.name,
//       'coachID': this.coachID,
//       'isCoach': this.isCoach
//     };
  
}