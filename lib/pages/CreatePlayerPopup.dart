import 'package:flutter/material.dart';



class CreatePlayerPopup extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _CreatePlayerPopupState();
}


class _CreatePlayerPopupState extends State<CreatePlayerPopup>{
final _formKey = new GlobalKey<FormState>();
String _playerName;
String _playerPosition;

  @override
  Widget build(BuildContext context) {
    return _createPlayerForm();
  }

  
  Widget _createPlayerForm(){
    return new Form(
      key: _formKey,
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _playerNameInput(),
          _showPlayerTypeDropdown(),
          _showConfirmButton(),
        ],
      ),
    );
  }

  Widget _playerNameInput(){
    return new Padding(
      padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: "Player Name",
          icon: new Icon(
            Icons.person,
            color: Colors.grey,
          )
        ),
        validator: (value) => value.isEmpty ? "Must enter player name" : null,
        onSaved: (value) => _playerName = value,
      ),
    );
  }

  Widget _showPlayerTypeDropdown(){
    return new Padding(
    padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
    child: new DropdownButton(
      items: 
      <String> ["Middle","Leftside","Setter",
              "Rightside","Libero","Utility"]
      .map(
      (position){
        return DropdownMenuItem(
          value: position,
          child: new Text(position),
        );
      }
    ).toList(),
    hint: new Text("Player position: $_playerPosition"),
    onChanged: (position){
      _playerPosition = position;
      this.setState((){});
    },
    )
    );
  }

  Widget _showConfirmButton(){
    return new Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new RaisedButton(
        child: new Text("Confirm"),
        onPressed: _validateAndSave,
      )
    );
  }

  void _validateAndSave(){
    // TODO: add player to DB
    final _form = _formKey.currentState;
    if (_form.validate()){
      _form.save();

    }
  }
}
