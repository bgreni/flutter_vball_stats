import 'package:flutter/widgets.dart';
import 'package:vball_stats/entities/Team.dart';
import 'package:flutter/material.dart';
import 'package:vball_stats/globals.dart' as globals;
import 'package:vball_stats/services/FirestoreHelper.dart';


class JoinTeamPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _JoinTeamPageState();
}


enum PageState{
  WAITING,
  INVALID,
}

class _JoinTeamPageState extends State<JoinTeamPage>{
  final _formKey = new GlobalKey<FormState>();
  PageState pageState = PageState.WAITING;
  String _enteredCode;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: new Text("Join Team"),
      ),
      body: _chooseBody(),
    );
  }

  Widget _chooseBody(){
    switch(pageState){
      case PageState.WAITING:
        return _waitingPage();
      case PageState.INVALID:
        return _invalidPage();
      default:
        _waitingPage();
    }
  }

  Widget _invalidPage(){
      return new Center(
      child: new Column(
        children: <Widget>[
          _inputForm(),
          _confirmButton(),
          _invalidText(),
        ],
      )
    );
  }

  Widget _invalidText(){
    return new Text("JOIN CODE DOES NOT EXIST",
    textAlign: TextAlign.center,
    style: new TextStyle(
      color: Colors.red,
      fontSize: 20.0
    ),);
  }

  Widget _waitingPage(){
      return new Center(
      child: new Column(
        children: <Widget>[
          _inputForm(),
          _confirmButton(),
        ],
      )
    );
  }


  Widget _inputForm(){
    return new Form(
      key: _formKey,
    child: 
    new Column(children:<Widget> [new Padding(
      padding: new EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: "Join Code"
        ),
        validator: (value) => value.isEmpty ? "Must enter a code" : null,
        onSaved: (value) => _enteredCode = value,
      ),
    )]));
  }

  Widget _confirmButton(){
    return new RaisedButton(
      child: new Text("Confirm"),
      onPressed: () => validator(),
    );
  }

  void validator() async{
    List<String> codes = await globals.fireHelper.getJoinCodes();
    if(codes.contains(_enteredCode)){
      _joinTeam();
    }
    setState(() {
     pageState = PageState.INVALID; 
    });

  }

  void _joinTeam() async{
    Team team = await globals.fireHelper.getTeamFromJoinCode(_enteredCode);
    globals.currentUser.myTeams.add(team.teamName);
    globals.fireHelper.updateUser();
    Navigator.pop(context);
  }

  
}