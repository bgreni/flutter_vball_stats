import 'Player.dart';
import 'package:json_annotation/json_annotation.dart';
part 'StatLine.g.dart';

@JsonSerializable(explicitToJson: true)

class StatLine {

  Player player;

  double kills;
  double continues;
  double blocks;
  double errors;
  double blocked;
  double digs;
  double aces;
  double serveErrors;

  double threes;
  double twos;
  double ones;
  double zeros;

  StatLine({this.player}) {
    this.kills = 0;
    this.continues = 0;
    this.blocks = 0;
    this.errors = 0;
    this.blocked = 0;
    this.digs = 0;
    this.aces = 0;
    this.serveErrors = 0;

    this.threes = 0;
    this.twos = 0;
    this.ones = 0;
    this.zeros = 0;
  }

  void mergeStatLines(StatLine inputStatLine) {
    this.kills += inputStatLine.kills;
    this.continues += inputStatLine.continues;
    this.blocks += inputStatLine.blocks;
    this.errors += inputStatLine.errors;
    this.blocked += inputStatLine.blocked;
    this.digs += inputStatLine.digs;
    this.aces += inputStatLine.aces;
    this.serveErrors += inputStatLine.serveErrors;

    this.threes += inputStatLine.threes;
    this.twos += inputStatLine.twos;
    this.ones += inputStatLine.ones;
    this.zeros += inputStatLine.zeros;
  }

  String getPassingAverage() {
    if (threes == 0 && twos == 0 && ones == 0 && zeros == 0) {
      return '0';
    }
    return (((3 * threes) +
                (2 * twos) +
                (ones) +
                (zeros)) /
            (threes + twos + ones + zeros))
        .toStringAsFixed(2);
  }

  StatLine getAverageFromGivenNumber(int number) {
    StatLine averageStatLine = new StatLine();
    averageStatLine.player = this.player;
    averageStatLine.kills = this.kills/number;
    averageStatLine.continues = this.continues/number;
    averageStatLine.blocks = this.blocks/number;
    averageStatLine.errors = this.errors/number;
    averageStatLine.blocked = this.blocked/number;
    averageStatLine.digs = this.digs/number;
    averageStatLine.aces = this.aces/number;
    averageStatLine.serveErrors = this.serveErrors/number;
    averageStatLine.threes = this.threes/number;
    averageStatLine.twos = this.twos/number;
    averageStatLine.ones = this.ones/number;
    averageStatLine.zeros = this.zeros/number;
    return averageStatLine;
  }

  factory StatLine.fromJson(Map<String, dynamic> json) => _$StatLineFromJson(json);
  Map<String, dynamic> toJson() => _$StatLineToJson(this);


  // StatLine fromJson(Map<String, dynamic> json) {
  //   return StatLine(
  //     player: Player().fromJson(json['player'].cast<String, dynamic>()))
  //     ..kills = json['kills']
  //     ..continues = json['continues']
  //     ..blocks = json['blocks']
  //     ..errors = json['errors']
  //     ..blocked = json['blocked']
  //     ..digs = json['digs']
  //     ..aces = json['aces']
  //     ..serveErrors = json['serveErrors']
  //     ..threes = json['threes']
  //     ..twos = json['twos']
  //     ..ones = json['ones']
  //     ..zeros = json['zeros'];
  // }

  // Map<String, dynamic> toJson() => <String, dynamic> {
  //   'player': this.player.toJson(),
  //   'kills': this.kills,
  //   'continues': this.continues,
  //   'blocks': this.blocks,
  //   'errors': this.errors,
  //   'blocked': this.blocked,
  //   'digs': this.digs,
  //   'aces': this.aces,
  //   'serveErrors': this.serveErrors,
  //   'threes': this.threes,
  //   'twos': this.twos,
  //   'ones': this.ones,
  //   'zeros': this.zeros,
  // };

}