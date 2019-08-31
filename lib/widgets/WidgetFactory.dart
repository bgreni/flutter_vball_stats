import 'package:flutter/material.dart';
import 'package:vball_stats/entities/StatLines.dart';

class WidgetFactory {

  static Widget createMutableStatsTable(StatLines statLines, VoidCallback callback) {
    return new DataTable(
              columns: [
                new DataColumn(label: new Text("Number")),
                new DataColumn(label: new Text("Player")),
                new DataColumn(label: new Text("Kills")),
                new DataColumn(label: new Text("Continues")),
                new DataColumn(label: new Text("Blocks")),
                new DataColumn(label: new Text("Errors")),
                new DataColumn(label: new Text("Digs")),
                new DataColumn(label: new Text("Aces")),
                new DataColumn(label: new Text("Serve Errors")),
              ],
              rows: <DataRow>[] +
                  statLines.statLineList
                      .map((statline) => DataRow(
                    
                        cells: [
                            DataCell(new Text(statline.player.playerNumber)),
                            DataCell(new Text(statline.player.name)),
                            DataCell(new Text(statline.kills.toString()),
                            onTap: (){statline.kills++; callback;}),
                            DataCell(new Text(statline.continues.toString()),
                            onTap: (){statline.continues++; callback;}),
                            DataCell(new Text(statline.blocks.toString()),
                            onTap: (){statline.blocks++; callback;}),
                            DataCell(new Text(statline.errors.toString()),
                            onTap: (){statline.errors++; callback;}),
                            DataCell(new Text(statline.digs.toString()),
                            onTap: (){statline.digs++; callback;}),
                            DataCell(new Text(statline.aces.toString()),
                            onTap: (){statline.aces++; callback;}),
                            DataCell(new Text(statline.serveErrors.toString()),
                            onTap: (){statline.serveErrors++; callback;}),
                          ]))
                      .toList());
  }

  static Widget createMutablePassingTable(StatLines statLines, VoidCallback setState) {
    return new DataTable(
          columns: [
            new DataColumn(label: new Text("Number")),
            new DataColumn(label: new Text("Player")),
            new DataColumn(label: new Text("Threes")),
            new DataColumn(label: new Text("Twos")),
            new DataColumn(label: new Text("Ones")),
            new DataColumn(label: new Text("Zeros")),
            new DataColumn(label: new Text("Average")),
          ],
          rows: <DataRow>[]+
          statLines.statLineList.map((statline) => DataRow(
            cells: [
              DataCell(new Text(statline.player.playerNumber)),
                  DataCell(new Text(statline.player.name)),
                  DataCell(new Text(statline.threes.toString()),
                  onTap:(){statline.threes++; setState;}),
                  DataCell(new Text(statline.twos.toString()),
                  onTap:(){statline.twos++; setState;}),
                  DataCell(new Text(statline.ones.toString()),
                  onTap:(){statline.ones++; setState;}),
                  DataCell(new Text(statline.zeros.toString()),
                  onTap:(){statline.zeros++; setState;}),
                  DataCell(new Text(statline.getPassingAverage())),
            ]
          )).toList(),
        );
  }
  
  static Widget createImmutableStatsTable(StatLines statLines) {
    return new DataTable(
              columns: [
                new DataColumn(label: new Text("Number")),
                new DataColumn(label: new Text("Player")),
                new DataColumn(label: new Text("Kills")),
                new DataColumn(label: new Text("Continues")),
                new DataColumn(label: new Text("Blocks")),
                new DataColumn(label: new Text("Errors")),
                new DataColumn(label: new Text("Digs")),
                new DataColumn(label: new Text("Aces")),
                new DataColumn(label: new Text("Serve Errors")),
              ],
              rows: <DataRow>[] +
                  statLines.statLineList
                      .map((statline) => DataRow(
                    
                        cells: [
                            DataCell(new Text(statline.player.playerNumber)),
                            DataCell(new Text(statline.player.name)),
                            DataCell(new Text(statline.kills.toString())),
                            DataCell(new Text(statline.continues.toString())),
                            DataCell(new Text(statline.blocks.toString())),
                            DataCell(new Text(statline.errors.toString())),
                            DataCell(new Text(statline.digs.toString())),
                            DataCell(new Text(statline.aces.toString())),
                            DataCell(new Text(statline.serveErrors.toString())),
                          ]))
                      .toList());
  }

  static Widget createImmutablePassingTable(StatLines statLines) {
    return new DataTable(
              columns: [
                new DataColumn(label: new Text("Number")),
                new DataColumn(label: new Text("Player")),
                new DataColumn(label: new Text("Threes")),
                new DataColumn(label: new Text("Twos")),
                new DataColumn(label: new Text("Ones")),
                new DataColumn(label: new Text("Zeros")),
                new DataColumn(label: new Text("Average")),
              ],
              rows: <DataRow>[] +
                  statLines.statLineList
                      .map((statline) => DataRow(cells: [
                            DataCell(new Text(statline.player.playerNumber)),
                            DataCell(new Text(statline.player.name)),
                            DataCell(new Text(statline.threes.toString())),
                            DataCell(new Text(statline.twos.toString())),
                            DataCell(new Text(statline.ones.toString())),
                            DataCell(new Text(statline.zeros.toString())),
                            DataCell(new Text(statline.getPassingAverage())),
                          ]))
                      .toList());
  }

}