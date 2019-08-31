import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';


class MomentumGraph extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MomentumGraphState();
}

class _MomentumGraphState extends State<MomentumGraph>{

  static List<int> scoreSequence;
  List<GraphPair> graphPoints;

  @override
  void initState() {
    super.initState();
    scoreSequence = [-1,-1,1,1,1,-1,1];
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 300.0,
      //width: 300.0, 
    child: new charts.LineChart(_createData(),animate: true,));
  }

  List<charts.Series<GraphPair,int>> _createData(){
    mapGraphPoints();
    return [
      new charts.Series<GraphPair,int>(
        id: "Score",
        colorFn: (_,__) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (GraphPair pair,_) => pair.index,
        measureFn: (GraphPair pair,__) => pair.point,
        data: graphPoints
      )
    ];
  }

  void mapGraphPoints(){
    graphPoints = new List();
    int total = 0;
    for (int i = 0; i < scoreSequence.length; i++){
      total += scoreSequence[i];
      graphPoints.add(new GraphPair(point: total,index: i));
    }
  }

  void addPoint(int point){
    scoreSequence.add(point);
    setState(() { 
    });
  }

}

class GraphPair{
  int point;
  int index;

  GraphPair({this.point, this.index});
}
