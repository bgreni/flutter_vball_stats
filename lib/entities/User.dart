

class User{
  String userID;
  String username;
  String email;
  bool isCoach;

  User({this.userID,this.email,this.isCoach,this.username});


  User fromJson(Map<String,dynamic> json){
    return User(
      userID: json['userID'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      isCoach: json['isCoach'] as bool,
     );
  }

  Map<String,dynamic> toJson() => <String,dynamic>{
    'userID': this.userID,
    'username': this.username,
    'email': this.email,
    'isCoach': this.isCoach,
  };
}