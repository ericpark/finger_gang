import 'dart:async';
import 'dart:math';

import 'package:finger_gang/game/game.dart';
import 'package:finger_gang/title/view/title_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SpinnerView extends StatefulWidget {
  const SpinnerView({
    required this.numberOfPlayers,
    super.key,
  });

  final int numberOfPlayers;

  // When this is false, it will only evaluate if all fingers are on the screen

  @override
  State<SpinnerView> createState() => _SpinnerViewState();
}

class _SpinnerViewState extends State<SpinnerView>
    with TickerProviderStateMixin {
  int seconds = 3;
  static const extraCycles = 5;

  RoundStatus status = RoundStatus.ready;
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  );
  late final AnimationController _avatarController = AnimationController(
    duration: const Duration(milliseconds: 3000),
    vsync: this,
  );
  Tween<double> _animation = Tween<double>(
    begin: 0,
    end: 2,
  );

  final double startingAngle = 3.14159 / 2; // start angle at 3/2 pi;
  int selectedPlayer = -1; // start angle at 3/2 pi;

  late List<Player> players = List<Player>.generate(
    widget.numberOfPlayers,
    (index) => Player(
      id: '$index',
      safe: false,
      ready: false,
    ),
  );

  final List<Interval> _itemSlideIntervals = [];

  @override
  void initState() {
    super.initState();
    _createAnimationIntervals();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _createAnimationIntervals() {
    final animationLength = _avatarController.duration!.inMilliseconds ~/
        widget.numberOfPlayers /
        extraCycles;
    for (var i = 0; i < widget.numberOfPlayers * extraCycles; ++i) {
      final startTime = 0 + (animationLength * i);
      final endTime = startTime + animationLength;
      _itemSlideIntervals.add(
        Interval(
          startTime / _avatarController.duration!.inMilliseconds,
          endTime / _avatarController.duration!.inMilliseconds,
        ),
      );
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
    final adjustedSize = (numberOfPoints > 8) ? avatarSize * 0.8 : avatarSize;
    final animationLength = _avatarController.duration!.inMilliseconds ~/
        widget.numberOfPlayers /
        extraCycles;
    for (var i = 0; i < numberOfPoints; i++) {
      final angle = startingAngle + (2 * 3.14159 * i / numberOfPoints);
      final x = centerX + radius * cos(angle);
      final y = centerY + radius * sin(angle);
      const defaultColor = Colors.grey;
      coordinates.add(
        Align(
          alignment: Alignment(x, y),
          child: AnimatedBuilder(
            animation: _avatarController,
            builder: (context, child) {
              final overallAnimationPercentage =
                  Curves.linear.transform(_avatarController.value);
              final currentCycle =
                  (overallAnimationPercentage * 100) ~/ (100 / extraCycles);
              final animationPercent = currentCycle < extraCycles
                  ? Curves.linear.transform(
                      _itemSlideIntervals[i + (numberOfPoints * currentCycle)]
                          .transform(_avatarController.value),
                    )
                  : 1;
              final show = animationPercent > 0 && animationPercent < 1;
              return AnimatedContainer(
                duration: Duration(milliseconds: animationLength.toInt()),
                height: adjustedSize,
                width: adjustedSize,
                child: CircleAvatar(
                  backgroundColor: i == selectedPlayer
                      ? Colors.green
                      : status == RoundStatus.playing && show
                          ? Colors.amber
                          : defaultColor,
                  child: Text('Player ${i + 1}'),
                ),
              );
            },
          ),
        ),
      );
    }

    return coordinates;
  }

  List<Player> evaluate() {
    return players.map((p) {
      return p.copyWith(ready: false);
    }).toList();
  }

  Future<void> start() async {
    final increasedPlayerIncrement = Random().nextInt(players.length) + 1;
    final previousPlayer = selectedPlayer;
    unawaited(HapticFeedback.vibrate());

    setState(() {
      selectedPlayer = -1;
      status = RoundStatus.playing;
      _animation = Tween<double>(
        begin: 0,
        end: extraCycles + (increasedPlayerIncrement / players.length),
      );
    });
    unawaited(_avatarController.forward());
    await _controller.forward().then((_) {
      setState(() {
        selectedPlayer =
            (previousPlayer + increasedPlayerIncrement) % players.length;
        status = RoundStatus.waiting;
      });
      _controller.reset();
    });

    _controller.reset();
    _avatarController.reset();

    await HapticFeedback.vibrate().then(
      (_) => setState(() {
        status = RoundStatus.ready;
      }),
    );
    await HapticFeedback.heavyImpact();
    await Future<void>.delayed(Durations.long4);
    await HapticFeedback.vibrate();
    await Future<void>.delayed(Durations.long4);
    await HapticFeedback.heavyImpact();
    await HapticFeedback.vibrate();
    await Future<void>.delayed(Durations.long4);
    await HapticFeedback.heavyImpact();
  }

  Future<void> end({String? msg}) async {
    unawaited(HapticFeedback.vibrate());

    setState(() {
      players = players.map((p) {
        if (p.status.isDone) return p;

        return p.copyWith(ready: false, status: PlayerStatus.lost);
      }).toList();
    });

    await HapticFeedback.vibrate();

    await Future<void>.delayed(const Duration(seconds: 3)).then(
      (value) => Navigator.of(context).pop(TitlePage.route()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final shorterSide = constraints.maxHeight < constraints.maxWidth
            ? constraints.maxHeight
            : constraints.maxWidth;
        final avatarSize = shorterSide * 0.30;

        final avatars =
            calculateCircleCoordinates(widget.numberOfPlayers, avatarSize)
              ..add(
                GestureDetector(
                  onLongPress: () {
                    if (status == RoundStatus.finished) return;
                    if (status == RoundStatus.waiting) return;

                    if (status == RoundStatus.ready) {
                      start();
                    }
                  },
                  child: Align(
                    child: RotationTransition(
                      turns: _animation.animate(_controller),
                      child: Transform.rotate(
                        angle: (3.14159 / 2) +
                            (startingAngle +
                                    (2 *
                                        3.14159 *
                                        ((selectedPlayer == -1
                                                ? 0
                                                : selectedPlayer) /
                                            players.length))) %
                                (3.14159 * 2),
                        child: Card(
                          child: SizedBox(
                            height: avatarSize * 0.9,
                            width: avatarSize * 0.9,
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Icon(Icons.arrow_upward, size: 80),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );

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
      },
    );
  }
}
