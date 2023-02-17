import 'package:mypack/core/viewmodels/base_viewmodel.dart';

import 'package:cards/src/wist/model.dart';

class WistGameModel extends IModel {
  WistGameModel();

  TablePositioned<Player> players = TablePositioned<Player>();
  List<Round> rounds = [];
  int _currentRoundnumber = 0;
  String message = "Deal cards and select trump";

  get currentTrump => currentRound.trump;

  @override
  void init({args}) {
    players = args as TablePositioned<Player>;
    rounds = buildRounds();

    notifyListeners();
  }

  int get currentRoundnumber => _currentRoundnumber;
  Round get currentRound => rounds[_currentRoundnumber];
  int get totalRounds => rounds.length;

  PlayerStatus? getPlayerStatus(TablePosition pos) => PlayerStatus(
        players.get(pos)!.name,
        bet: "${currentRound.bets.get(pos)}",
        score: getPlayersScore(pos),
        dealer: currentRound.dealer == pos,
      );

  void selectTrump(Seed? trump) {
    if (trump == null) {
      return;
    }
    currentRound.trump = trump;
    message = "Start betting";
    notifyListeners();
  }

  int getPlayersScore(pos) => rounds
      .where((r) => r.handWinner.contains(pos))
      .fold(0, (prev, r) => prev + 5 + (r.bets.get(pos) ?? 0));

  isEmpty(TablePosition pos) => players.get(pos) == null;

  List<Round> buildRounds() {
    List<Round> ret = [];
    var dealer = players.getRandom();
    int maxHands = 52 ~/ players.getN();
    for (var i = 1; i <= maxHands; i++) {
      ret.add(Round(
        dealer: dealer,
        hands: i,
        trumpExtraction: TrumpExtraction.random,
      ));
      dealer = players.getNext(dealer);
    }
    for (var i = 0; i < players.getN(); i++) {
      ret.add(Round(
        dealer: dealer,
        hands: maxHands,
        trumpExtraction: TrumpExtraction.pickFirst,
      ));
      dealer = players.getNext(dealer);
    }
    for (var i = 0; i < maxHands; i++) {
      ret.add(Round(
        dealer: dealer,
        hands: maxHands - i,
        trumpExtraction: TrumpExtraction.random,
      ));
      dealer = players.getNext(dealer);
    }
    return ret;
  }

  void nextRound() {
    _currentRoundnumber++;
  }
}

class PlayerStatus extends Player {
  PlayerStatus(super.name, {this.bet, this.score = 0, this.dealer = false});
  final String? bet;
  final int score;
  final bool dealer;
}
