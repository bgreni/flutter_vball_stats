import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vball_stats/pages/MyAppBar.dart';

class SeasonSelectPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _SeasonSelectState();

}


class _SeasonSelectState extends State<SeasonSelectPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new MyAppBar(appBarContext: context, barText: "Select Season",),
      body: _showBody(),
    );
  }

  Widget _showBody() {
    return new StreamBuilder(
      stream: Firestore.instance.collection("Teams").snapshots(),
      builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){

        if (snapshot.data == null) return CircularProgressIndicator();

        return new Center(
          child: Column()
        );
    });}
}