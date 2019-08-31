import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vball_stats/entities/User.dart';
import 'package:vball_stats/entities/Team.dart';
import 'package:vball_stats/globals.dart' as globals;
import 'package:vball_stats/services/authentication.dart';


class FirestoreHelper{

  void updateTeam(){
    Firestore.instance.collection("Teams").document(globals.currentTeam.teamID).updateData(globals.currentTeam.toJson());
  }


  void setJoinCode(String joinCode){
    Firestore.instance.collection("JoinCodes").document(globals.currentTeam.teamID).setData(<String,String>{'joinCode':joinCode});
  }

  Future<List<String>> getJoinCodes() async {
    var snap = await Firestore.instance.collection("JoinCodes").getDocuments();
    List<String> codeList = new List();
    for (var doc in snap.documents){
      codeList.add(doc['joinCode']);
    }
    return codeList;
  }

  Future<User> getUser(String id) async {
    var doc = await Firestore.instance.collection("Users").document(id).get();
    User user = User.fromJson(doc.data);
    return user;
  }

  void updateUser(){
    Firestore.instance.collection("Users").document(globals.currentUser.userID).updateData(globals.currentUser.toJson());
  }

  Future<Team> getTeamFromJoinCode(String joinCode) async {
    var doc = await Firestore.instance.collection("Teams").where("joinCode",isEqualTo: joinCode).snapshots().first;
    Team team = Team.fromJson(doc.documents.first.data);
    return team;
  }

  

  Future<Team> getTeamFromName(String teamName) async {
    var doc = await Firestore.instance.collection("Teams").where("teamName", isEqualTo: teamName).snapshots().first;
    Team team = Team.fromJson(doc.documents.first.data);
    return team;
  }  
}