import 'package:finger_gang/game/game.dart';
import 'package:finger_gang/l10n/l10n.dart';
import 'package:flutter/material.dart';

class FingersSurvivalView extends StatefulWidget {
  const FingersSurvivalView({super.key});

  @override
  State<FingersSurvivalView> createState() => _FingersSurvivalViewState();
}

class _FingersSurvivalViewState extends State<FingersSurvivalView> {
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
          const Spacer(),
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
          const Spacer(),
          SizedBox(
            width: 250,
            height: 64,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push<void>(
                  GamePage.route(
                    players: players,
                    useOnlyOn: false,
                    basicMode: true,
                  ),
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
