import 'package:flutter/material.dart';
import 'package:vball_stats/entities/StatLines.dart';
import 'package:vball_stats/entities/Team.dart';

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
                            DataCell(new Text(statline.kills.toStringAsFixed(0)),
                            onTap: (){statline.kills++; callback();}),
                            DataCell(new Text(statline.continues.toStringAsFixed(0)),
                            onTap: (){statline.continues++; callback();}),
                            DataCell(new Text(statline.blocks.toStringAsFixed(0)),
                            onTap: (){statline.blocks++; callback();}),
                            DataCell(new Text(statline.errors.toStringAsFixed(0)),
                            onTap: (){statline.errors++; callback();}),
                            DataCell(new Text(statline.digs.toStringAsFixed(0)),
                            onTap: (){statline.digs++; callback();}),
                            DataCell(new Text(statline.aces.toStringAsFixed(0)),
                            onTap: (){statline.aces++; callback();}),
                            DataCell(new Text(statline.serveErrors.toStringAsFixed(0)),
                            onTap: (){statline.serveErrors++; callback();}),
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
                  DataCell(new Text(statline.threes.toStringAsFixed(0)),
                  onTap:(){statline.threes++; setState();}),
                  DataCell(new Text(statline.twos.toStringAsFixed(0)),
                  onTap:(){statline.twos++; setState();}),
                  DataCell(new Text(statline.ones.toStringAsFixed(0)),
                  onTap:(){statline.ones++; setState();}),
                  DataCell(new Text(statline.zeros.toStringAsFixed(0)),
                  onTap:(){statline.zeros++; setState();}),
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
                            DataCell(new Text(statline.kills.toStringAsFixed(0))),
                            DataCell(new Text(statline.continues.toStringAsFixed(0))),
                            DataCell(new Text(statline.blocks.toStringAsFixed(0))),
                            DataCell(new Text(statline.errors.toStringAsFixed(0))),
                            DataCell(new Text(statline.digs.toStringAsFixed(0))),
                            DataCell(new Text(statline.aces.toStringAsFixed(0))),
                            DataCell(new Text(statline.serveErrors.toStringAsFixed(0))),
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
                            DataCell(new Text(statline.threes.toStringAsFixed(0))),
                            DataCell(new Text(statline.twos.toStringAsFixed(0))),
                            DataCell(new Text(statline.ones.toStringAsFixed(0))),
                            DataCell(new Text(statline.zeros.toStringAsFixed(0))),
                            DataCell(new Text(statline.getPassingAverage())),
                          ]))
                      .toList());
  }

  static Widget createGameAveragesTable(Team team) {
    StatLines averages = team.getGameAverages();
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
                new DataColumn(label: new Text("Threes")),
                new DataColumn(label: new Text("Twos")),
                new DataColumn(label: new Text("Ones")),
                new DataColumn(label: new Text("Zeros")),
              ],
              rows: <DataRow>[] +
                  averages.statLineList
                      .map((statline) => DataRow(cells: [
                            DataCell(new Text(statline.player.playerNumber)),
                            DataCell(new Text(statline.player.name)),
                            DataCell(new Text(statline.kills.toStringAsFixed(2))),
                            DataCell(new Text(statline.continues.toStringAsFixed(2))),
                            DataCell(new Text(statline.blocks.toStringAsFixed(2))),
                            DataCell(new Text(statline.errors.toStringAsFixed(2))),
                            DataCell(new Text(statline.digs.toStringAsFixed(2))),
                            DataCell(new Text(statline.aces.toStringAsFixed(2))),
                            DataCell(new Text(statline.serveErrors.toStringAsFixed(2))),
                            DataCell(new Text(statline.threes.toStringAsFixed(2))),
                            DataCell(new Text(statline.twos.toStringAsFixed(2))),
                            DataCell(new Text(statline.ones.toStringAsFixed(2))),
                            DataCell(new Text(statline.zeros.toStringAsFixed(2))),
                          ]))
                      .toList());
  }

}