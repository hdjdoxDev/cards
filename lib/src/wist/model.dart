import 'package:flutter/material.dart';

class Player {
  String name;

  Player(
    this.name,
  );
}

typedef Hand = int;

class TablePositioned<T> {
  TablePositioned();

  final Map<TablePosition, T> _elem = <TablePosition, T>{};

  static List<TablePosition> byRows = [
    TablePosition.nw,
    TablePosition.n,
    TablePosition.ne,
    TablePosition.w,
    TablePosition.c,
    TablePosition.e,
    TablePosition.sw,
    TablePosition.s,
    TablePosition.se,
  ];

  static List<TablePosition> byCircle = [
    TablePosition.nw,
    TablePosition.n,
    TablePosition.ne,
    TablePosition.e,
    TablePosition.se,
    TablePosition.s,
    TablePosition.sw,
    TablePosition.w,
  ];

  bool get isNotEmpty => _elem.isNotEmpty;

  bool isOccupied(TablePosition tp) => _elem.containsKey(tp);

  bool contains(T player) {
    return _elem.values.contains(player);
  }

  void add(TablePosition pos, T elem) => _elem[pos] = elem;

  TablePosition getNext(TablePosition pos) =>
      isOccupied(pos.next()) ? pos.next() : getNext(pos.next());

  T? get(TablePosition pos) => _elem[pos];

  getN() => _elem.length;

  TablePosition getRandom() => _elem.keys.toList().first;
}

enum TablePosition {
  n,
  ne,
  e,
  se,
  s,
  sw,
  w,
  nw,
  c;

  TablePosition next() {
    return TablePosition.values[(index + 1) % TablePosition.values.length - 1];
  }
}

enum Seed {
  spades,
  hearts,
  diamonds,
  clubs;

  @override
  String toString() {
    switch (this) {
      case Seed.spades:
        return "♠";
      case Seed.hearts:
        return "♥";
      case Seed.diamonds:
        return "♦";
      case Seed.clubs:
        return "♣";
    }
  }

  Color get color {
    switch (this) {
      case Seed.spades:
        return Colors.black;
      case Seed.hearts:
        return Colors.red;
      case Seed.diamonds:
        return Colors.red;
      case Seed.clubs:
        return Colors.black;
    }
  }
}

class Round {
  Round({
    required this.hands,
    required this.dealer,
    this.trumpExtraction = TrumpExtraction.random,
  });
  final Hand hands;
  final TrumpExtraction trumpExtraction;

  final TablePositioned<Hand> bets = TablePositioned<Hand>();
  final List<TablePosition> handWinner = <TablePosition>[];
  final TablePosition dealer;
  Seed? trump;
}

enum TrumpExtraction {
  pickFirst,
  random,
}
