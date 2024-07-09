import 'package:finger_gang/l10n/l10n.dart';
import 'package:finger_gang/spinner/spinner.dart';
import 'package:flutter/material.dart';

class SpinnerTitleView extends StatefulWidget {
  const SpinnerTitleView({super.key});

  @override
  State<SpinnerTitleView> createState() => _SpinnerTitleViewState();
}

class _SpinnerTitleViewState extends State<SpinnerTitleView> {
  int players = 3;
  int minPlayers = 2;
  int maxPlayers = 10;

  bool useOnlyOn = false;
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
                  SpinnerPage.route(players: players),
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
