import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WistView extends StatelessWidget {
  const WistView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wist'),
      ),
      body: Center(
        child: InkWell(
          onTap: () => Navigator.pushNamed(context, '/game_option'),
          child: Container(
            width: halfWidth(context),
            height: 200,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Theme.of(context).colorScheme.secondary,
                width: 2,
              ),
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: Icon(
              CupertinoIcons.play_arrow,
              size: 50,
              color: Theme.of(context).colorScheme.background,
            ),
          ),
        ),
      ),
    );
  }
}

double halfWidth(context) => MediaQuery.of(context).size.width / 2;
double thirdWidth(context) => MediaQuery.of(context).size.width / 3;
double quarterWidth(context) => MediaQuery.of(context).size.width / 4;
double halfHeight(context) => MediaQuery.of(context).size.height / 2;
double thirdHeight(context) => MediaQuery.of(context).size.height / 3;
double quarterHeight(context) => MediaQuery.of(context).size.height / 4;

