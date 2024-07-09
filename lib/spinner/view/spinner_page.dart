import 'package:finger_gang/spinner/spinner.dart';
import 'package:flutter/material.dart';

class SpinnerPage extends StatelessWidget {
  const SpinnerPage({
    required this.players,
    super.key,
  });

  final int players;

  static Route<void> route({
    required int players,
  }) {
    return MaterialPageRoute<void>(
      builder: (_) => SpinnerPage(
        players: players,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SpinnerView(numberOfPlayers: players),
      ),
    );
  }
}
