import 'package:flutter/material.dart';
import 'package:vball_stats/services/authentication.dart';
import 'root_page.dart';


class MyAppBar extends StatelessWidget implements PreferredSizeWidget{

  final Size preferredSize;
  final Auth auth;
  final appBarContext;
  final String barText;

  

  MyAppBar({this.appBarContext,this.barText}) : preferredSize = Size.fromHeight(56.0), auth = new Auth();


  void _select(Choice choice) async{
    switch (choice.pressedCode){
      case 1:
        await auth.signOut();
        Navigator.pushAndRemoveUntil(appBarContext, MaterialPageRoute(builder: (context) => RootPage(auth: this.auth)), ModalRoute.withName("login-page"));
        break;
    }

  }

  @override
  Widget build(BuildContext context) {
    List<Choice> buttonList = [
      Choice(title: "signOut",pressedCode: 1),
    ];
    return AppBar(
      title: new Text(this.barText),
      actions: <Widget>[
        PopupMenuButton<Choice>(
          onSelected: _select,
          itemBuilder: (context){
            return buttonList.map((Choice choice){
              return PopupMenuItem<Choice>(
                value: choice,
                child: Text(choice.title)
              );
            }
            ).toList();
          }
    ),]
    
    );
}
}


class Choice{

  final String title;
  final int pressedCode;

  Choice({this.title,this.pressedCode});

}


