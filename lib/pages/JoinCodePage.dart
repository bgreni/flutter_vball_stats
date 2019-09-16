import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:vball_stats/globals.dart' as globals;

enum PageState{
  WAITING,
  INVALID_CODE,
  VALID_CODE,
}


class JoinCodePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _JoinCodePageState();
}

class _JoinCodePageState extends State<JoinCodePage>{
  final _formKey = new GlobalKey<FormState>();
  String _joinCode;
  PageState pageState = PageState.WAITING;

  @override
  Widget build(BuildContext context) {
    switch(pageState){
      case PageState.WAITING:
        return _showInitPage();
      case PageState.INVALID_CODE:
        return _showInvalidPage();
      case PageState.VALID_CODE:
        return _showValidPage();
    }
  }
  
  Widget _showValidPage(){
    return new Center(
      child: new Column(
        children: <Widget>[
          _showExplanationText(),
          _showForm(),
          _validText(),
          ],
      ),
    );
  }

  Widget _validText(){
    return new Text("JOIN CODE SUCCESSFULLY CHANGED",
    textAlign: TextAlign.center,
    style: new TextStyle(
      fontSize: 20.0,
      color: Colors.green,
    ),);
  }
  

  Widget _showInvalidPage(){
    return new Center(
      child: new Column(
        children: <Widget>[
          _showExplanationText(),
          _showForm(),
          _invalidInpuText(),
          ],
      ),
    );
  }

  Widget _invalidInpuText(){
    return new Text("JOIN CODE IS ALREADY IN USE",
    textAlign: TextAlign.center,
    style: new TextStyle(
      fontSize: 20.0,
      color: Colors.red,
    ));
  }

  Widget _showInitPage(){
    return new Center(
      child: new Column(
        children: <Widget>[
          _showExplanationText(),
          _showForm(),
          ],
      ),
    );
  }

  Widget _showExplanationText(){
    return new Padding(
      padding: new EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 30.0),
      child: new Text("Use this page to set you teams join code. Your players and "+
    "assistant coaches can use this code to join your team and view your teams recorded "+
    "games and stats",textAlign: TextAlign.center,));
  }

  Widget _showForm(){
    return new Form(
      key: _formKey,
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
        _showCodeInput(),
        _confirmButton(),
      ],),
    );

  }

  Widget _showCodeInput(){
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 30.0),
      child: new Container(
        width: 300,
        child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.text,
        decoration: new InputDecoration(
          hintText: "New Join Code"
        ),
        autofocus: false,
        validator: (value) => value.isEmpty ? "Must enter a code" : null,
        onSaved: (value) => _joinCode = value,
      )),
    );
  }

  Widget _confirmButton(){
    return new RaisedButton(
      child: new Text("Confirm"),
      onPressed: _validateAndSave,
    );
  }

  void _validateAndSave() async{
    final _form = _formKey.currentState;
    if(_form.validate()){
      _form.save();
      bool isValid = await validator();
      if(isValid){
        globals.currentTeam.joinCode = _joinCode;
        globals.fireHelper.updateTeam();
        globals.fireHelper.setJoinCode(_joinCode);
        setState(() {
         pageState = PageState.VALID_CODE; 
        });}
      else{
        setState(() {
          pageState = PageState.INVALID_CODE;
        });
      }
      }
    }

  Future<bool> validator() async{
    List<String> codes = await globals.fireHelper.getJoinCodes();
    if(codes.isEmpty || !codes.contains(_joinCode)){
      return true;
    }
    return false;
  }
}