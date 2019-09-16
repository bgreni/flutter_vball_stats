import 'package:flutter/material.dart';
import "package:vball_stats/services/authentication.dart";
import 'package:vball_stats/pages/root_page.dart';

void main() => runApp(VballStatsApp());

class VballStatsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Vball Stats App',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          // main color theme for the app
          primarySwatch: Colors.blue,
        ),
        // set root authorization page
        home: new RootPage(auth: new Auth()));
  }
}

    