import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mypack/ui/shared/layout.dart';
import 'package:mypack/ui/views/base_view.dart';

import 'option_vm.dart';
import 'model.dart';

class WistOptionView extends StatelessWidget {
  const WistOptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomView<WistOptionModel>(
      title: 'Start New Game',
      builder: (context, model, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // player insertion
          Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var i in TablePositioned.byRows.sublist(0, 3))
                      if (i != TablePosition.c)
                        PlayerOptionW(
                          player: model.players.get(i),
                          position: i,
                          onTap: model.addPlayer,
                        ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var i in TablePositioned.byRows.sublist(3, 6))
                      if (i != TablePosition.c)
                        PlayerOptionW(
                          player: model.players.get(i),
                          position: i,
                          onTap: model.addPlayer,
                        )
                      else
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).colorScheme.secondary,
                                width: 2),
                          ),
                          width: 200,
                          height: 100,
                          child: const Center(
                            child: Text(
                              "Game Table",
                            ),
                          ),
                        ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var i in TablePositioned.byRows.sublist(6, 9))
                      if (i != TablePosition.c)
                        PlayerOptionW(
                          player: model.players.get(i),
                          position: i,
                          onTap: model.addPlayer,
                        ),
                  ],
                ),
              ],
            ),
          ),
          Center(
            child: MyIconButton(
              iconData: CupertinoIcons.play,
              color: Theme.of(context).colorScheme.secondary,
              onTap: () {
                if (model.players.isNotEmpty)
                {Navigator.pushNamed(context, "/game",
                  arguments: model.players);}
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PlayerOptionW extends StatefulWidget {
  final Player? player;
  final TablePosition position;
  final void Function(TablePosition, String) onTap;

  const PlayerOptionW({
    super.key,
    this.player,
    required this.position,
    required this.onTap,
  });

  @override
  State<PlayerOptionW> createState() => _PlayerOptionWState();
}

class _PlayerOptionWState extends State<PlayerOptionW> {
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    _controller.text = widget.player?.name ?? "";

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 150,
      alignment: Alignment.center,
      child: widget.player == null
          ? MyIconButton(
              color: Theme.of(context).colorScheme.secondary,
              iconData: CupertinoIcons.add,
              onTap: () => showCupertinoDialog<String>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Header(widget.player != null
                      ? widget.player!.name
                      : "Add Player"),
                  content: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: TextField(
                          onSubmitted: (value) => Navigator.pop(context, value),
                          autofocus: true,
                          controller: _controller,
                        ),
                      ),
                      MyIconButton(
                        color: Theme.of(context).colorScheme.secondary,
                        iconData: CupertinoIcons.check_mark,
                        onTap: () => Navigator.pop(context, _controller.text),
                      ),
                    ],
                  ),
                ),
              ).then(
                (newName) => widget.onTap(widget.position, newName ?? ""),
              ),
            )
          : Text(widget.player!.name),
    );
  }
}
