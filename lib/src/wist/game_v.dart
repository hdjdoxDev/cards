import 'package:cards/src/wist/wist_v.dart';
import 'package:flutter/material.dart';
import 'package:mypack/ui/views/base_view.dart';

import 'game_vm.dart';
import 'model.dart';

class WistGameView extends StatelessWidget {
  const WistGameView({super.key});

  @override
  Widget build(BuildContext context) {
    // get gametable from route
    final TablePositioned<Player> players =
        ModalRoute.of(context)!.settings.arguments as TablePositioned<Player>;

    return CustomView<WistGameModel>(
      title: "Wist Game",
      initModel: (model) => model.init(args: players),
      builder: (context, model, child) => Center(
        child: GridView.count(
          childAspectRatio: 1.4,
          crossAxisCount: 3,
          children: [
            for (var pos in TablePositioned.byRows)
              Container(
                alignment: Alignment.center,
                width: quarterWidth(context),
                height: quarterHeight(context),
                child: pos == TablePosition.c
                    ? GameStatusW(model)
                    : model.isEmpty(pos)
                        ? const EmptySeatW()
                        : PlayerStatusW(model.getPlayerStatus(pos)!),
              ),
          ],
        ),
      ),
    );
  }
}

class GameStatusW extends StatelessWidget {
  const GameStatusW(this.model, {super.key});
  final WistGameModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary,
          width: 2,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 10,
            top: 10,
            child: Text(
              "${model.currentRound.hands}",
            ),
          ),
          Positioned(
              right: 10,
              top: 10,
              child: TrumpW(
                  selectTrump: model.selectTrump,
                  selected: model.currentTrump)),
          Positioned(
            left: 10,
            bottom: 10,
            child: Text(
              "${model.currentRoundnumber}/${model.totalRounds}",
            ),
          ),
          const Positioned(
            right: 10,
            bottom: 10,
            child: Text(
              "Proceed",
            ),
          ),
        ],
      ),
    );
  }
}

class TrumpW extends StatelessWidget {
  final void Function(Seed?) selectTrump;
  final Seed? selected;
  const TrumpW({super.key, required this.selectTrump, this.selected});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              child: Text(
                Seed.diamonds.toString(),
              ),
              onPressed: () => selectTrump(Seed.diamonds),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              child: Text(
                Seed.hearts.toString(),
              ),
              onPressed: () => selectTrump(Seed.hearts),
            ),
            TextButton(
              child: Text(
                Seed.spades.toString(),
              ),
              onPressed: () => selectTrump(Seed.spades),
            ),
          ],
        )
      ],
    );
  }
}

class TrumpIconW extends StatelessWidget {
  final Seed seed;
  final bool isSelected;
  final void Function(Seed?) selectTrump;
  const TrumpIconW(
      {super.key,
      required this.seed,
      required this.isSelected,
      required this.selectTrump});

  @override
  Widget build(BuildContext context) {
    return isSelected
        ? TextButton(
            child: Text(
              seed.toString(),
              style: TextStyle(
                color: seed.color,
              ),
            ),
            onPressed: () => selectTrump(seed),
          )
        : TextButton(
            child: Text(
              seed.toString(),
              style: TextStyle(
                color: Theme.of(context).colorScheme.background,
              ),
            ),
            onPressed: () => selectTrump(seed),
          );
  }
}

class PlayerStatusW extends StatelessWidget {
  const PlayerStatusW(this.ps, {super.key});
  final PlayerStatus ps;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(ps.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text("${ps.score}"), Text("${ps.bet}")],
        ),
        trailing: ps.dealer
            ? const Icon(
                Icons.star,
                color: Colors.yellow,
              )
            : null);
  }
}

class EmptySeatW extends StatelessWidget {
  const EmptySeatW({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Empty Seat",
        style: TextStyle(
          color: Theme.of(context).colorScheme.background,
          shadows: [
            Shadow(
              blurRadius: 10.0,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ],
        ),
      ),
    );
  }
}
