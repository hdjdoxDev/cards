import 'package:cards/locator.dart';
import 'package:flutter/material.dart';

import 'src/wist/option_v.dart';
import 'src/wist/game_v.dart';
import 'src/wist/wist_v.dart';

void main() {
  setupLocator();

  runApp(const Cards());
}

class Cards extends StatelessWidget {
  const Cards({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cards',
      theme: ThemeData(
        fontFamily: "RobotoMono",
        colorScheme: const ColorScheme.dark(
          primary: Colors.white,
          secondary: Colors.yellow,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WistView(),
        '/game_option': (context) => const WistOptionView(),
        '/game': (context) => const WistGameView(),
      },
    );
  }
}
