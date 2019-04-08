import 'package:flutter/material.dart';

void main() => runApp(GettingStartedApp());

class GettingStartedApp extends StatelessWidget{
  @override
    Widget build(BuildContext context) {
      return new MaterialApp(
        title: "Getting Started",
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text("My App")
          ),
          body: new HomeWidget(),
        )
      );
    }
}

class HomeWidget extends StatelessWidget{
    @override
      Widget build(BuildContext context) {
        return new ListView.builder(
          itemCount: 20,
          itemBuilder: (context,rowNumber){
            return new Container(
              padding: new EdgeInsets.all(16.0),
              child:   new Column(
              children: <Widget>[
                new Image.network("https://www.oliosmarket.com/uploads/5/0/8/4/50849417/s861601039261965101_p9_i1_w2560.jpeg"),
                new Text("BUTTER BOIS",
                  style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 19.0),),
                new Divider(color: Colors.green),
              ],
            )
            );
          }
        );
              
      }
}

