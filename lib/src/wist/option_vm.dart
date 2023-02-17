import 'package:mypack/core/viewmodels/base_viewmodel.dart';

import 'model.dart';

class WistOptionModel extends IModel {
  // table
  TablePositioned<Player> players = TablePositioned<Player>();
  void addPlayer(TablePosition tp, String name) {
    if (players.contains(Player(name))) {
      return;
    }
    players.add(tp, Player(name));
    notifyListeners();
  }
}
