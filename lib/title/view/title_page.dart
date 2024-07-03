import 'package:finger_gang/game/game.dart';
import 'package:finger_gang/l10n/l10n.dart';
import 'package:flutter/material.dart';

class TitlePage extends StatelessWidget {
  const TitlePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const TitlePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.titleAppBarTitle),
      ),
      body: const SafeArea(child: TitleView()),
    );
  }
}

class TitleView extends StatefulWidget {
  const TitleView({super.key});

  @override
  State<TitleView> createState() => _TitleViewState();
}

class _TitleViewState extends State<TitleView> {
  int players = 3;
  int minPlayers = 2;
  int maxPlayers = 5;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                icon: const Icon(Icons.remove),
                onPressed: players > minPlayers
                    ? () {
                        setState(() {
                          players--;
                        });
                      }
                    : null,
                label: const Text(''),
              ),
              SizedBox(
                height: 64,
                child: Center(
                  child: Text(
                    'Players: $players',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              TextButton.icon(
                icon: const Icon(Icons.add),
                onPressed: players < maxPlayers
                    ? () {
                        setState(() {
                          players++;
                        });
                      }
                    : null,
                label: const Text(''),
              ),
            ],
          ),
          SizedBox(
            width: 250,
            height: 64,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push<void>(
                  GamePage.route(players: players),
                );
              },
              child: Center(child: Text(l10n.titleButtonStart)),
            ),
          ),
        ],
      ),
    );
  }
}
