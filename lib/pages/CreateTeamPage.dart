import 'package:flutter/material.dart';
import 'package:vball_stats/entities/Team.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vball_stats/globals.dart' as globals;


class CreateTeamPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _CreateTeamPageState();
  
}



class _CreateTeamPageState extends State<CreateTeamPage>{
  String _teamName;
  final _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: new Text("Well Shit"),
    ),
    body:_buildBody()
    );
  }

  Widget _buildBody(){
    return new Form(
      key: _formKey,
      child: new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        _teamNameInput(),
        _confirmButton()
      ],
    ),
    );
  }


  Widget _confirmButton(){
    return Padding(
      padding: new EdgeInsets.fromLTRB(50.0, 100.0, 100.0, 0.0),
      child: RaisedButton(
      child: new Text("Confirm"),
      onPressed: _validate,
    )
    );
  }

  void _validate(){
    final form = _formKey.currentState;
    if(form.validate()){
      form.save();
      var ref = Firestore.instance.collection("Teams").document();

      Team newTeam = Team(teamName: _teamName,headCoach: globals.currentUser,teamID: ref.documentID);
      var json = newTeam.toJson();
      Firestore.instance.collection("Teams").document(ref.documentID).setData(json);

      globals.currentUser.myTeams.add(newTeam.teamName);
      Firestore.instance.collection("Users").document(globals.currentUser.userID).updateData(globals.currentUser.toJson());
      Navigator.pop(context);
    }
  }

  Widget _teamNameInput(){
  return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Team Name',
            icon: new Icon(
              Icons.title,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Must enter a team name' : null,
        onSaved: (value) => _teamName = value,
      ),
    );
  }

}
