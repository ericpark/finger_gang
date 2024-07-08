import 'dart:async';
import 'dart:math';

import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:finger_gang/game/game.dart';
import 'package:finger_gang/title/view/title_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FingersViewBasic extends StatefulWidget {
  const FingersViewBasic({
    required this.numberOfPlayers,
    super.key,
  });

  final int numberOfPlayers;

  @override
  State<FingersViewBasic> createState() => _FingersViewBasicState();
}

class _FingersViewBasicState extends State<FingersViewBasic> {
  int seconds = 3;
  String message = 'Ready?';
  RoundStatus status = RoundStatus.ready;

  late List<Player> players = List<Player>.generate(
    widget.numberOfPlayers,
    (index) => Player(
      id: '$index',
      safe: false,
      ready: false,
    ),
  );

  @override
  void initState() {
    super.initState();
  }

  void detectPress(int i) {
    if (status == RoundStatus.finished) return;
    if (status == RoundStatus.waiting) return;

    if (status == RoundStatus.ready || status == RoundStatus.playing) {
      setState(() {
        if (players[i].status.isPlaying) {
          players[i] = players[i].copyWith(ready: true);
          //color = Colors.amber;
        } else {
          players[i] = players[i].copyWith(ready: false);
          /*if (players[i].status == PlayerStatus.won) {
                      color = Colors.green;
                    }
                    if (players[i].status == PlayerStatus.lost) {
                      color = Colors.red;
                    }*/
        }
      });
    }

    final playersOn =
        players.where((p) => p.ready && p.status.isPlaying).length;
    final remainingPlayers = players.where((p) => p.status.isPlaying).length;

    // IF ALL FINGERS ARE ON = START
    if (status == RoundStatus.ready && playersOn == remainingPlayers) {
      start();
    }
  }

  List<Widget> calculateCircleCoordinates(
    int numberOfPoints,
    double avatarSize,
  ) {
    final coordinates = <Widget>[];

    const radius = 1.0; // adjust the radius as needed
    const centerX = 0.0; // adjust the center X coordinate as needed
    const centerY = 0.0; // adjust the center Y coordinate as needed
    const startAngle = 3.14159 / 2; // start angle at 3/2 pi

    for (var i = 0; i < numberOfPoints; i++) {
      final angle = startAngle + (2 * 3.14159 * i / numberOfPoints);
      final x = centerX + radius * cos(angle);
      final y = centerY + radius * sin(angle);
      const defaultColor = Colors.grey;
      coordinates.add(
        Align(
          alignment: Alignment(x, y),
          child: GestureDetector(
            onTapDown: (details) {
              if (status == RoundStatus.ready ||
                  status == RoundStatus.playing) {
                HapticFeedback.lightImpact();
              }
            },
            onLongPressStart: (details) {
              detectPress(i);
              if (status == RoundStatus.ready ||
                  status == RoundStatus.playing) {
                HapticFeedback.heavyImpact();
              }
            },
            onLongPressEnd: (details) {
              if (status == RoundStatus.finished) return;
              if (status == RoundStatus.waiting) return;
              // Keep showing whatever the locked in color is
              if (status == RoundStatus.ready ||
                  status == RoundStatus.playing) {
                /* final remainingPlayers =
                    players.where((p) => p.status.isPlaying).length;

                final playersOn =
                    players.where((p) => p.ready && p.status.isPlaying).length;
*/
                setState(() {
                  if (players[i].status.isPlaying) {
                    players[i] = players[i].copyWith(ready: false);
                    //color = Colors.grey;
                  } else {
                    players[i] = players[i].copyWith(ready: false);
                    /*if (players[i].status == PlayerStatus.won) {
                      color = Colors.green;
                    }
                    if (players[i].status == PlayerStatus.lost) {
                      color = Colors.red;
                    }*/
                  }
                });
              }
            },
            child: SizedBox(
              height: avatarSize,
              width: avatarSize,
              child: CircleAvatar(
                backgroundColor: players[i].status == PlayerStatus.won
                    ? Colors.green
                    : players[i].status == PlayerStatus.lost
                        ? Colors.red
                        : players[i].ready
                            ? Colors.amber
                            : defaultColor,
                child: Text('Player ${i + 1}'),
              ),
            ),
          ),
        ),
      );
    }

    return coordinates;
  }

  /// Evaluation:
  /// ON/OFF
  List<Player> evaluate({required bool onWins}) {
    // Players who are on become safe.
    if (onWins) {
      return players.map((p) {
        if (p.status.isDone) return p;
        if (p.ready) {
          return p.copyWith(
            ready: false,
            status: PlayerStatus.won,
          );
        }
        return p.copyWith(ready: false);
      }).toList();
    } else {
      return players.map((p) {
        if (p.status.isDone) return p;
        // People who are off win
        if (!p.ready) {
          return p.copyWith(
            ready: false,
            status: PlayerStatus.won,
          );
        }
        return p.copyWith(ready: false);
      }).toList();
    }
  }

  Future<void> start() async {
    final onWins = Random().nextBool();

    setState(() {
      status = RoundStatus.playing;
    });

    for (var i = seconds; i > 0; i--) {
      setState(() {
        message = '$i';
      });
      await HapticFeedback.heavyImpact();
      await Future<void>.delayed(const Duration(milliseconds: 900));
    }

    setState(() {
      message = onWins ? 'ON' : 'OFF';
      status = RoundStatus.waiting;
    });
    await Future<void>.delayed(const Duration(seconds: 2));

    final updatedPlayers = evaluate(onWins: onWins);
    setState(() {
      players = updatedPlayers;
    });
    await Future<void>.delayed(const Duration(seconds: 2));

    setState(() {
      message = 'Ready?';
      status = RoundStatus.ready;
    });
  }

  Future<void> end({String? msg}) async {
    setState(() {
      message = msg ?? 'Game Over!';
    });
    unawaited(HapticFeedback.heavyImpact());
    unawaited(HapticFeedback.heavyImpact());
    unawaited(HapticFeedback.heavyImpact());

    await Future<void>.delayed(const Duration(seconds: 3)).then(
      (value) => Navigator.of(context).pop(TitlePage.route()),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (players.where((p) => p.status == PlayerStatus.won).length ==
        players.length) {
      end(msg: 'EVERYONE WINS! :)');
    } else if (players.where((p) => p.status == PlayerStatus.lost).length ==
        players.length) {
      end(msg: 'EVERYONE LOSES! :(');
    } else if (players.where((p) => p.status.isPlaying).length == 1) {
      final playerId =
          int.parse(players.firstWhere((p) => p.status.isPlaying).id);
      end(msg: 'PLAYER ${playerId + 1} LOSES!');
    }
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final shorterSide = constraints.maxHeight < constraints.maxWidth
            ? constraints.maxHeight
            : constraints.maxWidth;
        final avatarSize = shorterSide * 0.30;

        final avatars =
            calculateCircleCoordinates(widget.numberOfPlayers, avatarSize)
              ..add(
                Align(
                  child: AnimatedSwitcherPlus.zoomOut(
                    scaleInFactor: 3,
                    scaleOutFactor: 0.5,
                    duration: const Duration(milliseconds: 750),
                    child: Card(
                      key: ValueKey(message),
                      child: SizedBox(
                        height: avatarSize * 0.9,
                        width: avatarSize * 0.9,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              message,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );

        if (widget.numberOfPlayers == 3) {
          return Center(
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.center,
                child: Stack(children: avatars),
              ),
            ),
          );
        }
        return Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            child: Stack(children: avatars),
          ),
        );
      },
    );
  }
}
