import 'package:flutter/material.dart';
import 'package:vball_stats/pages/login_page.dart';
import 'package:vball_stats/services/authentication.dart';
import 'package:vball_stats/pages/TeamSelect.dart';
import 'package:vball_stats/globals.dart' as globals;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vball_stats/entities/User.dart';



class RootPage extends StatefulWidget {
  RootPage({this.auth});

  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";

  @override
  void initState(){
    super.initState();
    widget.auth.getCurrentUser().then((user) async{
      if (user != null) {
      var userSnap = await Firestore.instance.collection("Users").document(user.uid.toString()).get();
       globals.currentUser = User.fromJson(userSnap.data);
      }
      setState(() {
        if (user != null) {
          _userId = user.uid;
        }
        authStatus =
            _userId == "" ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
  }

  void _onLoggedIn() {
    widget.auth.getCurrentUser().then((user) {
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;
      _userId = user.uid.toString();

    });
  });}

   void _onSignedOut() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
    });
  }

  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return _buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return new LoginSignUpPage(
          auth: widget.auth,
          onSignedIn: _onLoggedIn,
        );
        break;
      case AuthStatus.LOGGED_IN:
        if (_userId.length > 0 && _userId != null) {
          return new TeamSelect(
            userID: _userId,
        );
        } else return _buildWaitingScreen();
        break;
      default:
        return _buildWaitingScreen();
    }
  }
}